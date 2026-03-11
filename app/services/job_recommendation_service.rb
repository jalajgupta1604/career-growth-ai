class JobRecommendationService
  def initialize(user)
    @user = user
  end

  def generate_recommendations
    user_skills = fetch_user_skills
    listings = find_matching_listings(user_skills)

    listings.map do |listing|
      score_data = calculate_match(listing, user_skills)
      next if score_data[:score] < 0.2

      JobRecommendation.find_or_create_by!(user: @user, job_listing: listing) do |rec|
        rec.match_score = score_data[:score]
        rec.match_reasons = score_data[:reasons]
        rec.skill_matches = score_data[:skill_matches]
      end
    end.compact
  end

  def ai_recommendations
    user_skills = fetch_user_skills
    prompt = GeminiPrompts.job_recommendations_prompt(build_user_profile, user_skills)
    result = GeminiClient.new.generate(prompt, response_schema: recommendations_schema)

    return [] unless result

    jobs = result["jobs"] || []
    jobs.each do |job|
      listing = JobListing.find_or_create_by!(
        title: job["title"],
        company_name: job["company_name"]
      ) do |l|
        l.location = job["location"]
        l.job_type = job["job_type"]
        l.min_salary = job["min_salary"]
        l.max_salary = job["max_salary"]
        l.description = job["description"]
        l.required_skills = job["required_skills"] || []
        l.experience_range = job["experience_range"]
        l.source = "ai_generated"
        l.posted_at = Time.current
      end

      JobRecommendation.find_or_create_by!(user: @user, job_listing: listing) do |rec|
        rec.match_score = (job["match_score"].to_f / 100.0).clamp(0, 1)
        rec.match_reasons = job["match_reasons"] || []
        rec.skill_matches = { matched: job["matched_skills"] || [], missing: job["missing_skills"] || [] }
      end
    end
  end

  def dashboard_data
    recs = @user.job_recommendations.includes(:job_listing).by_score.limit(20)
    {
      recommendations: recs,
      total_count: @user.job_recommendations.count,
      new_count: @user.job_recommendations.unseen.count,
      saved_count: @user.job_recommendations.saved.count,
      applied_count: @user.job_recommendations.applied.count,
      top_match: recs.first
    }
  end

  private

  def fetch_user_skills
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    resume_skills = resume&.parsed_data&.dig("skills") || []
    linkedin_skills = @user.linkedin_profile&.skills_list || []
    (resume_skills + linkedin_skills).map(&:downcase).uniq
  end

  def find_matching_listings(user_skills)
    JobListing.active_listings.select do |listing|
      listing_skills = listing.skills_list.map(&:downcase)
      (listing_skills & user_skills).any?
    end
  end

  def calculate_match(listing, user_skills)
    required = (listing.required_skills || []).map(&:downcase)
    preferred = (listing.preferred_skills || []).map(&:downcase)
    all_skills = (required + preferred).uniq

    matched = all_skills & user_skills
    missing = all_skills - user_skills

    skill_score = all_skills.any? ? (matched.size.to_f / all_skills.size) : 0.5

    location_score = listing.location&.downcase&.include?(@user.city.to_s.downcase) ? 0.2 : 0
    exp_score = experience_match(listing) ? 0.2 : 0

    total = (skill_score * 0.6 + location_score + exp_score).clamp(0, 1).round(2)

    reasons = []
    reasons << "#{matched.size} skill match" if matched.any?
    reasons << "Location match" if location_score > 0
    reasons << "Experience match" if exp_score > 0

    { score: total, reasons: reasons, skill_matches: { matched: matched, missing: missing } }
  end

  def experience_match(listing)
    return true unless listing.experience_range.present?
    range = listing.experience_range
    years = @user.experience_years.to_i
    case range
    when /(\d+)-(\d+)/ then ($1.to_i..$2.to_i).include?(years)
    when /(\d+)\+/ then years >= $1.to_i
    else true
    end
  end

  def build_user_profile
    {
      role: @user.role,
      city: @user.city,
      experience_years: @user.experience_years,
      current_salary: @user.current_salary
    }
  end

  def recommendations_schema
    {
      type: "OBJECT",
      properties: {
        jobs: {
          type: "ARRAY",
          items: {
            type: "OBJECT",
            properties: {
              title: { type: "STRING" },
              company_name: { type: "STRING" },
              location: { type: "STRING" },
              job_type: { type: "STRING" },
              min_salary: { type: "NUMBER" },
              max_salary: { type: "NUMBER" },
              description: { type: "STRING" },
              required_skills: { type: "ARRAY", items: { type: "STRING" } },
              experience_range: { type: "STRING" },
              match_score: { type: "INTEGER" },
              match_reasons: { type: "ARRAY", items: { type: "STRING" } },
              matched_skills: { type: "ARRAY", items: { type: "STRING" } },
              missing_skills: { type: "ARRAY", items: { type: "STRING" } }
            }
          }
        }
      }
    }
  end
end
