class LinkedinService
  def initialize(user)
    @user = user
  end

  def import_profile(linkedin_data)
    profile = @user.linkedin_profile || @user.build_linkedin_profile

    profile.update!(
      linkedin_uid: linkedin_data[:uid],
      linkedin_url: linkedin_data[:url],
      headline: linkedin_data[:headline],
      industry: linkedin_data[:industry],
      location: linkedin_data[:location],
      connections_count: linkedin_data[:connections_count],
      positions_data: linkedin_data[:positions] || [],
      education_data: linkedin_data[:education] || [],
      skills_data: linkedin_data[:skills] || [],
      certifications_data: linkedin_data[:certifications] || [],
      raw_profile_data: linkedin_data[:raw] || {},
      sync_status: "synced",
      last_synced_at: Time.current
    )

    sync_skills_to_resume(profile)
    profile
  end

  def manual_import(params)
    profile = @user.linkedin_profile || @user.build_linkedin_profile

    positions = parse_positions(params[:positions_text])
    skills = parse_skills(params[:skills_text])

    profile.update!(
      linkedin_url: params[:linkedin_url],
      headline: params[:headline],
      industry: params[:industry],
      location: params[:location] || @user.city,
      positions_data: positions,
      skills_data: skills,
      sync_status: "manual",
      last_synced_at: Time.current
    )

    sync_skills_to_resume(profile)
    profile
  end

  def profile_insights
    profile = @user.linkedin_profile
    return nil unless profile

    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    resume_skills = resume&.parsed_data&.dig("skills") || []
    linkedin_skills = profile.skills_list

    all_skills = (resume_skills.map(&:downcase) + linkedin_skills.map(&:downcase)).uniq
    only_linkedin = linkedin_skills.map(&:downcase) - resume_skills.map(&:downcase)
    only_resume = resume_skills.map(&:downcase) - linkedin_skills.map(&:downcase)

    {
      total_skills: all_skills.size,
      linkedin_skills: linkedin_skills.size,
      resume_skills: resume_skills.size,
      only_on_linkedin: only_linkedin,
      only_on_resume: only_resume,
      common_skills: (resume_skills.map(&:downcase) & linkedin_skills.map(&:downcase)),
      headline: profile.headline,
      current_position: profile.current_position,
      experience_years_linkedin: profile.experience_years_from_linkedin,
      positions_count: (profile.positions_data || []).size,
      last_synced: profile.last_synced_at
    }
  end

  private

  def sync_skills_to_resume(profile)
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    return unless resume

    existing_skills = resume.parsed_data&.dig("skills") || []
    linkedin_skills = profile.skills_list
    merged = (existing_skills.map(&:downcase) + linkedin_skills.map(&:downcase)).uniq

    resume.update!(parsed_data: resume.parsed_data.merge("skills" => merged))
  end

  def parse_positions(text)
    return [] if text.blank?
    text.split("\n").map(&:strip).reject(&:empty?).map do |line|
      parts = line.split(/\s*[-–@at]\s*/i, 2)
      { "title" => parts[0]&.strip, "company" => parts[1]&.strip }
    end
  end

  def parse_skills(text)
    return [] if text.blank?
    text.split(/[,\n]/).map(&:strip).reject(&:empty?)
  end
end
