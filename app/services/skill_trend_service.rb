class SkillTrendService
  CURRENT_PERIOD = -> { Date.current.strftime("%Y-%m") }

  def initialize(role: nil, city: nil)
    @role = role
    @city = city
  end

  def trending_skills(limit: 20)
    scope = SkillTrend.for_period(CURRENT_PERIOD.call)
    scope = scope.for_role(@role) if @role.present?
    scope.top_demand.limit(limit)
  end

  def rising_skills(limit: 10)
    scope = SkillTrend.for_period(CURRENT_PERIOD.call).trending_up
    scope = scope.for_role(@role) if @role.present?
    scope.top_demand.limit(limit)
  end

  def declining_skills(limit: 10)
    scope = SkillTrend.for_period(CURRENT_PERIOD.call).trending_down
    scope = scope.for_role(@role) if @role.present?
    scope.order(demand_score: :asc).limit(limit)
  end

  def skill_detail(skill_name)
    trends = SkillTrend.where(skill_name: skill_name)
                       .where(role: @role)
                       .order(:period)
                       .limit(12)

    return nil if trends.empty?

    latest = trends.last
    {
      skill_name: skill_name,
      current_demand: latest.demand_score,
      salary_premium: latest.salary_premium_pct,
      trend_direction: latest.trend_direction,
      history: trends.map { |t| { period: t.period, demand: t.demand_score, premium: t.salary_premium_pct } }
    }
  end

  def seed_trends_from_skills
    period = CURRENT_PERIOD.call
    skills = Skill.all

    skills.each do |skill|
      roles = RoleSkillMapping.where(skill: skill).pluck(:role).uniq

      roles.each do |role|
        trend_direction = case
                          when skill.demand_index >= 8 then "rising"
                          when skill.demand_index >= 5 then "stable"
                          else "declining"
                          end

        SkillTrend.find_or_create_by!(skill_name: skill.name, role: role, period: period) do |t|
          t.demand_score = (skill.demand_index * 10).round
          t.salary_premium_pct = skill.salary_uplift_index.to_f * 10
          t.trend_direction = trend_direction
          t.job_postings_count = rand(50..500)
          t.monthly_data = []
        end
      end
    end
  end

  def dashboard_data
    {
      trending: trending_skills,
      rising: rising_skills,
      declining: declining_skills,
      total_skills_tracked: SkillTrend.for_period(CURRENT_PERIOD.call).count,
      available_roles: SkillTrend.for_period(CURRENT_PERIOD.call).distinct.pluck(:role).compact.sort
    }
  end
end
