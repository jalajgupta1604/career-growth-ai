class CandidateMatchingService
  WEIGHTS = {
    skills: 0.35,
    experience: 0.25,
    location: 0.15,
    salary: 0.15,
    engagement: 0.10
  }.freeze

  def initialize(job_posting)
    @job = job_posting
  end

  def find_matches(limit: 20)
    candidates = base_candidates
    scored = candidates.map { |user| [user, calculate_score(user)] }
    scored.sort_by { |_, score| -score }.first(limit)
  end

  def match_score(user)
    calculate_score(user)
  end

  private

  def base_candidates
    scope = User.where(user_type: "job_seeker")
    scope = scope.where.not(role: nil)

    # Filter by privacy settings
    scope = scope.where("privacy_settings->>'profile_visible' != ?", "false")

    scope.limit(500)
  end

  def calculate_score(user)
    scores = {
      skills: skill_match_score(user),
      experience: experience_match_score(user),
      location: location_match_score(user),
      salary: salary_match_score(user),
      engagement: engagement_score(user)
    }

    total = scores.sum { |key, score| score * WEIGHTS[key] }
    (total * 100).round(1)
  end

  def skill_match_score(user)
    return 0.5 unless @job.respond_to?(:requirements) && @job.requirements.present?

    job_skills = extract_skills(@job.requirements.to_s + " " + @job.description.to_s)
    user_skills = user_skill_set(user)

    return 0.5 if job_skills.empty?

    matched = (job_skills & user_skills).size
    matched.to_f / job_skills.size
  end

  def experience_match_score(user)
    return 0.5 unless user.experience_years.present?

    job_min = @job.respond_to?(:min_experience) ? @job.min_experience.to_i : 0
    job_max = @job.respond_to?(:max_experience) ? @job.max_experience.to_i : 20

    if user.experience_years.between?(job_min, job_max)
      1.0
    elsif user.experience_years < job_min
      diff = job_min - user.experience_years
      [1.0 - (diff * 0.15), 0].max
    else
      diff = user.experience_years - job_max
      [1.0 - (diff * 0.1), 0.3].max
    end
  end

  def location_match_score(user)
    return 0.8 if @job.respond_to?(:remote) && @job.remote
    return 0.5 unless user.city.present? && @job.respond_to?(:location)

    user.city.to_s.downcase == @job.location.to_s.downcase ? 1.0 : 0.3
  end

  def salary_match_score(user)
    return 0.5 unless user.current_salary.present?
    return 0.5 unless @job.respond_to?(:max_salary) && @job.max_salary.present?

    if user.current_salary <= @job.max_salary
      1.0
    else
      over = (user.current_salary - @job.max_salary).to_f / @job.max_salary
      [1.0 - over, 0].max
    end
  end

  def engagement_score(user)
    score = user.engagement_score.to_f / 100.0
    score.clamp(0, 1)
  end

  def extract_skills(text)
    common_skills = %w[python javascript java ruby react node aws docker kubernetes sql
                       golang typescript rust flutter swift kotlin tensorflow pytorch
                       react-native angular vue redis mongodb postgresql kafka
                       terraform jenkins microservices graphql]
    text_lower = text.downcase
    common_skills.select { |s| text_lower.include?(s) }
  end

  def user_skill_set(user)
    skills = []

    # From career reports
    report = user.career_reports.order(created_at: :desc).first
    if report
      skills.concat(Array(report.try(:top_skills) || []))
    end

    # From role
    skills << user.role.to_s.downcase if user.role.present?

    # From resume
    resume = user.resumes.order(created_at: :desc).first
    if resume&.respond_to?(:parsed_skills)
      skills.concat(Array(resume.parsed_skills))
    end

    skills.map(&:downcase).uniq
  end
end
