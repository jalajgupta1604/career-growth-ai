class SkillGapService
  def initialize(user, user_skills: [])
    @user = user
    @user_skills = user_skills.map(&:downcase)
  end

  def analyze
    required_mappings = RoleSkillMapping.for_role(@user.role).includes(:skill)
    return { missing_skills: [], matched_skills: [], skill_match_percentage: 0 } if required_mappings.empty?

    matched = []
    missing = []

    required_mappings.each do |mapping|
      skill = mapping.skill
      if @user_skills.include?(skill.name.downcase)
        matched << build_skill_data(skill, mapping, matched: true)
      else
        missing << build_skill_data(skill, mapping, matched: false)
      end
    end

    # Sort missing skills by ROI (highest first)
    missing.sort_by! { |s| -s[:roi_score] }

    total_weight = required_mappings.sum(&:importance_weight).to_f
    matched_weight = matched.sum { |s| s[:importance_weight] }
    skill_match_percentage = total_weight.zero? ? 0 : (matched_weight / total_weight * 100).round(1)

    {
      matched_skills: matched,
      missing_skills: missing,
      skill_match_percentage: skill_match_percentage,
      top_skills_to_learn: missing.first(5)
    }
  end

  private

  def build_skill_data(skill, mapping, matched:)
    {
      name: skill.name,
      category: skill.category,
      importance_weight: mapping.importance_weight,
      demand_index: skill.demand_index,
      salary_uplift_index: skill.salary_uplift_index,
      learning_difficulty_index: skill.learning_difficulty_index,
      roi_score: skill.roi_score.round(2),
      matched: matched
    }
  end
end
