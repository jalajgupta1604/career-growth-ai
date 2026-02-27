class CareerReportGeneratorService
  def initialize(user)
    @user = user
  end

  def generate
    # Get resume skills
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    user_skills = resume&.parsed_data&.dig("skills") || []

    # Salary analysis
    salary_service = SalaryBenchmarkService.new(@user)
    salary_data = salary_service.analyze

    # Skill gap analysis
    skill_gap_service = SkillGapService.new(@user, user_skills: user_skills)
    skill_gap_data = skill_gap_service.analyze

    # Interview score
    interview_service = InterviewScoreService.new(
      @user,
      skill_gap_data: skill_gap_data,
      parsed_resume_data: resume&.parsed_data || {}
    )
    interview_data = interview_service.calculate

    # Roadmap
    roadmap_service = RoadmapService.new(@user, skill_gap_data: skill_gap_data, salary_data: salary_data)
    roadmap_data = roadmap_service.generate

    # Create the report
    @user.career_reports.create!(
      salary_gap_percentage: salary_data&.dig(:underpaid_percentage) || 0,
      skill_gap_data: {
        salary_analysis: salary_data,
        skill_analysis: skill_gap_data
      },
      roadmap_data: {
        roadmap: roadmap_data,
        interview: interview_data
      },
      interview_score: interview_data[:total_score],
      payment_status: :unpaid
    )
  end
end
