class InterviewScoreService
  SKILL_MATCH_WEIGHT = 0.5
  EXPERIENCE_WEIGHT = 0.3
  PROJECT_DEPTH_WEIGHT = 0.2

  def initialize(user, skill_gap_data:, parsed_resume_data: {})
    @user = user
    @skill_gap_data = skill_gap_data
    @parsed_resume_data = parsed_resume_data
  end

  def calculate
    skill_score = skill_match_score
    exp_score = experience_score
    project_score = project_depth_score

    total = (skill_score * SKILL_MATCH_WEIGHT +
             exp_score * EXPERIENCE_WEIGHT +
             project_score * PROJECT_DEPTH_WEIGHT).round(1)

    {
      total_score: [total, 100].min,
      skill_match_score: skill_score.round(1),
      experience_score: exp_score.round(1),
      project_depth_score: project_score.round(1),
      readiness_level: readiness_level(total)
    }
  end

  private

  def skill_match_score
    @skill_gap_data[:skill_match_percentage] || 0
  end

  def experience_score
    years = @user.experience_years.to_i
    # Score based on experience relevance (0-100)
    case years
    when 0..1 then 30
    when 2..3 then 50
    when 4..6 then 70
    when 7..10 then 85
    else 95
    end
  end

  def project_depth_score
    projects = @parsed_resume_data["projects"] || []
    certifications = @parsed_resume_data["certifications"] || []

    base_score = 40
    base_score += [projects.length * 10, 30].min
    base_score += [certifications.length * 10, 30].min
    [base_score, 100].min
  end

  def readiness_level(score)
    case score
    when 0..30 then "needs_preparation"
    when 31..50 then "developing"
    when 51..70 then "competitive"
    when 71..85 then "strong"
    else "exceptional"
    end
  end
end
