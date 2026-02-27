class RoadmapService
  def initialize(user, skill_gap_data:, salary_data:)
    @user = user
    @skill_gap_data = skill_gap_data
    @salary_data = salary_data
  end

  def generate
    missing_skills = @skill_gap_data[:top_skills_to_learn] || []

    {
      timeline: build_timeline(missing_skills),
      certifications: recommended_certifications,
      salary_projection: salary_projection,
      milestones: build_milestones(missing_skills)
    }
  end

  private

  def build_timeline(missing_skills)
    months = []
    missing_skills.each_with_index do |skill, index|
      start_month = (index * 2) + 1
      end_month = start_month + 1
      months << {
        skill: skill[:name],
        start_month: start_month,
        end_month: [end_month, 12].min,
        difficulty: skill[:learning_difficulty_index],
        expected_salary_uplift: skill[:salary_uplift_index]
      }
    end
    months
  end

  def recommended_certifications
    role_certs = {
      "Software Developer" => ["AWS Certified Developer", "Oracle Java Certification", "Microsoft Azure Developer"],
      "QA Engineer" => ["ISTQB Foundation", "Certified Selenium Professional", "AWS Certified Cloud Practitioner"],
      "Data Analyst" => ["Google Data Analytics Certificate", "Microsoft Power BI Certification", "AWS Data Analytics"],
      "DevOps Engineer" => ["AWS Solutions Architect", "Certified Kubernetes Administrator", "HashiCorp Terraform Associate"],
      "Frontend Developer" => ["Meta Front-End Developer Certificate", "AWS Certified Cloud Practitioner", "Google UX Design"],
      "Backend Developer" => ["AWS Certified Developer", "Oracle Java Certification", "MongoDB Certified Developer"],
      "Full Stack Developer" => ["AWS Certified Developer", "Meta Full-Stack Engineer Certificate", "MongoDB Certified Developer"],
      "Data Scientist" => ["Google Advanced Data Analytics", "AWS Machine Learning Specialty", "TensorFlow Developer Certificate"],
      "Product Manager" => ["Certified Scrum Product Owner", "PMP Certification", "Google Project Management Certificate"]
    }
    role_certs[@user.role] || ["AWS Certified Cloud Practitioner", "Google IT Support Certificate"]
  end

  def salary_projection
    current = @user.current_salary.to_f
    median = @salary_data&.dig(:benchmark)&.median_salary.to_f

    {
      current_salary: current,
      projected_6_months: (current * 1.10).round(0),
      projected_12_months: (current * 1.25).round(0),
      market_median: median,
      potential_increase_percentage: median.zero? ? 0 : (((median - current) / current) * 100).round(1)
    }
  end

  def build_milestones(missing_skills)
    milestones = []

    milestones << {
      month: 1,
      title: "Foundation",
      description: "Complete skill assessment and begin learning #{missing_skills.first&.dig(:name) || 'core skills'}"
    }

    milestones << {
      month: 3,
      title: "Skill Building",
      description: "Build projects using newly learned technologies"
    }

    milestones << {
      month: 6,
      title: "Certification",
      description: "Obtain first industry certification"
    }

    milestones << {
      month: 9,
      title: "Portfolio Enhancement",
      description: "Complete 2-3 portfolio projects demonstrating new skills"
    }

    milestones << {
      month: 12,
      title: "Career Advancement",
      description: "Ready for next-level role with updated skills and certifications"
    }

    milestones
  end
end
