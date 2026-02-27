puts "Seeding salary benchmarks..."

# Salary data (annual in INR) for major Indian IT cities
salary_data = [
  # Software Developer
  { role: "Software Developer", city: "Bangalore", experience_range: "0-2", min_salary: 400000, median_salary: 600000, max_salary: 1000000, company_type: "Product" },
  { role: "Software Developer", city: "Bangalore", experience_range: "3-5", min_salary: 800000, median_salary: 1400000, max_salary: 2200000, company_type: "Product" },
  { role: "Software Developer", city: "Bangalore", experience_range: "6-8", min_salary: 1500000, median_salary: 2400000, max_salary: 3800000, company_type: "Product" },
  { role: "Software Developer", city: "Bangalore", experience_range: "9-12", min_salary: 2200000, median_salary: 3500000, max_salary: 5500000, company_type: "Product" },
  { role: "Software Developer", city: "Bangalore", experience_range: "12+", min_salary: 3000000, median_salary: 5000000, max_salary: 8000000, company_type: "Product" },

  { role: "Software Developer", city: "Mumbai", experience_range: "0-2", min_salary: 380000, median_salary: 550000, max_salary: 900000, company_type: "Product" },
  { role: "Software Developer", city: "Mumbai", experience_range: "3-5", min_salary: 750000, median_salary: 1300000, max_salary: 2000000, company_type: "Product" },
  { role: "Software Developer", city: "Mumbai", experience_range: "6-8", min_salary: 1400000, median_salary: 2200000, max_salary: 3500000, company_type: "Product" },
  { role: "Software Developer", city: "Mumbai", experience_range: "9-12", min_salary: 2000000, median_salary: 3200000, max_salary: 5000000, company_type: "Product" },
  { role: "Software Developer", city: "Mumbai", experience_range: "12+", min_salary: 2800000, median_salary: 4500000, max_salary: 7500000, company_type: "Product" },

  { role: "Software Developer", city: "Delhi", experience_range: "0-2", min_salary: 350000, median_salary: 520000, max_salary: 850000, company_type: "Product" },
  { role: "Software Developer", city: "Delhi", experience_range: "3-5", min_salary: 700000, median_salary: 1200000, max_salary: 1900000, company_type: "Product" },
  { role: "Software Developer", city: "Delhi", experience_range: "6-8", min_salary: 1300000, median_salary: 2100000, max_salary: 3300000, company_type: "Product" },
  { role: "Software Developer", city: "Delhi", experience_range: "9-12", min_salary: 1900000, median_salary: 3000000, max_salary: 4800000, company_type: "Product" },
  { role: "Software Developer", city: "Delhi", experience_range: "12+", min_salary: 2600000, median_salary: 4200000, max_salary: 7000000, company_type: "Product" },

  { role: "Software Developer", city: "Hyderabad", experience_range: "0-2", min_salary: 370000, median_salary: 560000, max_salary: 920000, company_type: "Product" },
  { role: "Software Developer", city: "Hyderabad", experience_range: "3-5", min_salary: 770000, median_salary: 1350000, max_salary: 2100000, company_type: "Product" },
  { role: "Software Developer", city: "Hyderabad", experience_range: "6-8", min_salary: 1450000, median_salary: 2300000, max_salary: 3600000, company_type: "Product" },
  { role: "Software Developer", city: "Hyderabad", experience_range: "9-12", min_salary: 2100000, median_salary: 3400000, max_salary: 5200000, company_type: "Product" },
  { role: "Software Developer", city: "Hyderabad", experience_range: "12+", min_salary: 2900000, median_salary: 4800000, max_salary: 7800000, company_type: "Product" },

  { role: "Software Developer", city: "Pune", experience_range: "0-2", min_salary: 360000, median_salary: 540000, max_salary: 880000, company_type: "Product" },
  { role: "Software Developer", city: "Pune", experience_range: "3-5", min_salary: 720000, median_salary: 1250000, max_salary: 2000000, company_type: "Product" },
  { role: "Software Developer", city: "Pune", experience_range: "6-8", min_salary: 1350000, median_salary: 2200000, max_salary: 3400000, company_type: "Product" },
  { role: "Software Developer", city: "Pune", experience_range: "9-12", min_salary: 2000000, median_salary: 3100000, max_salary: 4900000, company_type: "Product" },
  { role: "Software Developer", city: "Pune", experience_range: "12+", min_salary: 2700000, median_salary: 4400000, max_salary: 7200000, company_type: "Product" },

  { role: "Software Developer", city: "Chennai", experience_range: "0-2", min_salary: 340000, median_salary: 500000, max_salary: 820000, company_type: "Product" },
  { role: "Software Developer", city: "Chennai", experience_range: "3-5", min_salary: 680000, median_salary: 1200000, max_salary: 1850000, company_type: "Product" },
  { role: "Software Developer", city: "Chennai", experience_range: "6-8", min_salary: 1300000, median_salary: 2100000, max_salary: 3200000, company_type: "Product" },
  { role: "Software Developer", city: "Chennai", experience_range: "9-12", min_salary: 1900000, median_salary: 3000000, max_salary: 4600000, company_type: "Product" },
  { role: "Software Developer", city: "Chennai", experience_range: "12+", min_salary: 2500000, median_salary: 4100000, max_salary: 6800000, company_type: "Product" },

  # Frontend Developer
  { role: "Frontend Developer", city: "Bangalore", experience_range: "0-2", min_salary: 400000, median_salary: 620000, max_salary: 1000000, company_type: "Product" },
  { role: "Frontend Developer", city: "Bangalore", experience_range: "3-5", min_salary: 850000, median_salary: 1500000, max_salary: 2300000, company_type: "Product" },
  { role: "Frontend Developer", city: "Bangalore", experience_range: "6-8", min_salary: 1600000, median_salary: 2500000, max_salary: 4000000, company_type: "Product" },
  { role: "Frontend Developer", city: "Bangalore", experience_range: "9-12", min_salary: 2300000, median_salary: 3600000, max_salary: 5500000, company_type: "Product" },
  { role: "Frontend Developer", city: "Mumbai", experience_range: "0-2", min_salary: 380000, median_salary: 580000, max_salary: 950000, company_type: "Product" },
  { role: "Frontend Developer", city: "Mumbai", experience_range: "3-5", min_salary: 800000, median_salary: 1400000, max_salary: 2100000, company_type: "Product" },
  { role: "Frontend Developer", city: "Mumbai", experience_range: "6-8", min_salary: 1500000, median_salary: 2300000, max_salary: 3600000, company_type: "Product" },
  { role: "Frontend Developer", city: "Hyderabad", experience_range: "0-2", min_salary: 380000, median_salary: 580000, max_salary: 920000, company_type: "Product" },
  { role: "Frontend Developer", city: "Hyderabad", experience_range: "3-5", min_salary: 800000, median_salary: 1400000, max_salary: 2200000, company_type: "Product" },
  { role: "Frontend Developer", city: "Pune", experience_range: "0-2", min_salary: 370000, median_salary: 560000, max_salary: 900000, company_type: "Product" },
  { role: "Frontend Developer", city: "Pune", experience_range: "3-5", min_salary: 750000, median_salary: 1300000, max_salary: 2000000, company_type: "Product" },

  # Backend Developer
  { role: "Backend Developer", city: "Bangalore", experience_range: "0-2", min_salary: 420000, median_salary: 650000, max_salary: 1050000, company_type: "Product" },
  { role: "Backend Developer", city: "Bangalore", experience_range: "3-5", min_salary: 900000, median_salary: 1550000, max_salary: 2400000, company_type: "Product" },
  { role: "Backend Developer", city: "Bangalore", experience_range: "6-8", min_salary: 1700000, median_salary: 2600000, max_salary: 4200000, company_type: "Product" },
  { role: "Backend Developer", city: "Bangalore", experience_range: "9-12", min_salary: 2400000, median_salary: 3800000, max_salary: 6000000, company_type: "Product" },
  { role: "Backend Developer", city: "Mumbai", experience_range: "0-2", min_salary: 400000, median_salary: 600000, max_salary: 980000, company_type: "Product" },
  { role: "Backend Developer", city: "Mumbai", experience_range: "3-5", min_salary: 850000, median_salary: 1450000, max_salary: 2200000, company_type: "Product" },
  { role: "Backend Developer", city: "Hyderabad", experience_range: "0-2", min_salary: 400000, median_salary: 610000, max_salary: 1000000, company_type: "Product" },
  { role: "Backend Developer", city: "Hyderabad", experience_range: "3-5", min_salary: 850000, median_salary: 1500000, max_salary: 2300000, company_type: "Product" },

  # Full Stack Developer
  { role: "Full Stack Developer", city: "Bangalore", experience_range: "0-2", min_salary: 450000, median_salary: 700000, max_salary: 1100000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Bangalore", experience_range: "3-5", min_salary: 950000, median_salary: 1600000, max_salary: 2500000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Bangalore", experience_range: "6-8", min_salary: 1800000, median_salary: 2800000, max_salary: 4500000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Bangalore", experience_range: "9-12", min_salary: 2500000, median_salary: 4000000, max_salary: 6500000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Mumbai", experience_range: "0-2", min_salary: 420000, median_salary: 650000, max_salary: 1000000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Mumbai", experience_range: "3-5", min_salary: 900000, median_salary: 1500000, max_salary: 2300000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Hyderabad", experience_range: "0-2", min_salary: 430000, median_salary: 660000, max_salary: 1050000, company_type: "Product" },
  { role: "Full Stack Developer", city: "Hyderabad", experience_range: "3-5", min_salary: 900000, median_salary: 1550000, max_salary: 2400000, company_type: "Product" },

  # QA Engineer
  { role: "QA Engineer", city: "Bangalore", experience_range: "0-2", min_salary: 300000, median_salary: 480000, max_salary: 750000, company_type: "Product" },
  { role: "QA Engineer", city: "Bangalore", experience_range: "3-5", min_salary: 600000, median_salary: 1000000, max_salary: 1600000, company_type: "Product" },
  { role: "QA Engineer", city: "Bangalore", experience_range: "6-8", min_salary: 1100000, median_salary: 1800000, max_salary: 2800000, company_type: "Product" },
  { role: "QA Engineer", city: "Bangalore", experience_range: "9-12", min_salary: 1600000, median_salary: 2500000, max_salary: 4000000, company_type: "Product" },
  { role: "QA Engineer", city: "Mumbai", experience_range: "0-2", min_salary: 280000, median_salary: 450000, max_salary: 700000, company_type: "Product" },
  { role: "QA Engineer", city: "Mumbai", experience_range: "3-5", min_salary: 560000, median_salary: 950000, max_salary: 1500000, company_type: "Product" },
  { role: "QA Engineer", city: "Hyderabad", experience_range: "0-2", min_salary: 290000, median_salary: 470000, max_salary: 730000, company_type: "Product" },
  { role: "QA Engineer", city: "Hyderabad", experience_range: "3-5", min_salary: 580000, median_salary: 980000, max_salary: 1550000, company_type: "Product" },
  { role: "QA Engineer", city: "Pune", experience_range: "0-2", min_salary: 270000, median_salary: 440000, max_salary: 680000, company_type: "Product" },
  { role: "QA Engineer", city: "Pune", experience_range: "3-5", min_salary: 540000, median_salary: 920000, max_salary: 1450000, company_type: "Product" },

  # Data Analyst
  { role: "Data Analyst", city: "Bangalore", experience_range: "0-2", min_salary: 400000, median_salary: 600000, max_salary: 950000, company_type: "Product" },
  { role: "Data Analyst", city: "Bangalore", experience_range: "3-5", min_salary: 800000, median_salary: 1300000, max_salary: 2000000, company_type: "Product" },
  { role: "Data Analyst", city: "Bangalore", experience_range: "6-8", min_salary: 1400000, median_salary: 2200000, max_salary: 3500000, company_type: "Product" },
  { role: "Data Analyst", city: "Bangalore", experience_range: "9-12", min_salary: 2000000, median_salary: 3200000, max_salary: 5000000, company_type: "Product" },
  { role: "Data Analyst", city: "Mumbai", experience_range: "0-2", min_salary: 380000, median_salary: 570000, max_salary: 900000, company_type: "Product" },
  { role: "Data Analyst", city: "Mumbai", experience_range: "3-5", min_salary: 750000, median_salary: 1200000, max_salary: 1850000, company_type: "Product" },
  { role: "Data Analyst", city: "Hyderabad", experience_range: "0-2", min_salary: 370000, median_salary: 560000, max_salary: 880000, company_type: "Product" },
  { role: "Data Analyst", city: "Hyderabad", experience_range: "3-5", min_salary: 740000, median_salary: 1250000, max_salary: 1950000, company_type: "Product" },

  # Data Scientist
  { role: "Data Scientist", city: "Bangalore", experience_range: "0-2", min_salary: 500000, median_salary: 800000, max_salary: 1300000, company_type: "Product" },
  { role: "Data Scientist", city: "Bangalore", experience_range: "3-5", min_salary: 1100000, median_salary: 1800000, max_salary: 2800000, company_type: "Product" },
  { role: "Data Scientist", city: "Bangalore", experience_range: "6-8", min_salary: 1800000, median_salary: 3000000, max_salary: 5000000, company_type: "Product" },
  { role: "Data Scientist", city: "Bangalore", experience_range: "9-12", min_salary: 2500000, median_salary: 4200000, max_salary: 7000000, company_type: "Product" },
  { role: "Data Scientist", city: "Mumbai", experience_range: "0-2", min_salary: 480000, median_salary: 750000, max_salary: 1200000, company_type: "Product" },
  { role: "Data Scientist", city: "Mumbai", experience_range: "3-5", min_salary: 1000000, median_salary: 1700000, max_salary: 2600000, company_type: "Product" },
  { role: "Data Scientist", city: "Hyderabad", experience_range: "0-2", min_salary: 480000, median_salary: 780000, max_salary: 1250000, company_type: "Product" },
  { role: "Data Scientist", city: "Hyderabad", experience_range: "3-5", min_salary: 1050000, median_salary: 1750000, max_salary: 2700000, company_type: "Product" },

  # DevOps Engineer
  { role: "DevOps Engineer", city: "Bangalore", experience_range: "0-2", min_salary: 450000, median_salary: 700000, max_salary: 1100000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Bangalore", experience_range: "3-5", min_salary: 1000000, median_salary: 1700000, max_salary: 2600000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Bangalore", experience_range: "6-8", min_salary: 1800000, median_salary: 2800000, max_salary: 4500000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Bangalore", experience_range: "9-12", min_salary: 2500000, median_salary: 4000000, max_salary: 6500000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Mumbai", experience_range: "0-2", min_salary: 420000, median_salary: 650000, max_salary: 1000000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Mumbai", experience_range: "3-5", min_salary: 950000, median_salary: 1600000, max_salary: 2400000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Hyderabad", experience_range: "0-2", min_salary: 430000, median_salary: 680000, max_salary: 1050000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Hyderabad", experience_range: "3-5", min_salary: 980000, median_salary: 1650000, max_salary: 2500000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Pune", experience_range: "0-2", min_salary: 400000, median_salary: 640000, max_salary: 980000, company_type: "Product" },
  { role: "DevOps Engineer", city: "Pune", experience_range: "3-5", min_salary: 900000, median_salary: 1550000, max_salary: 2300000, company_type: "Product" },

  # Product Manager
  { role: "Product Manager", city: "Bangalore", experience_range: "3-5", min_salary: 1200000, median_salary: 2000000, max_salary: 3200000, company_type: "Product" },
  { role: "Product Manager", city: "Bangalore", experience_range: "6-8", min_salary: 2000000, median_salary: 3200000, max_salary: 5000000, company_type: "Product" },
  { role: "Product Manager", city: "Bangalore", experience_range: "9-12", min_salary: 2800000, median_salary: 4500000, max_salary: 7500000, company_type: "Product" },
  { role: "Product Manager", city: "Mumbai", experience_range: "3-5", min_salary: 1100000, median_salary: 1850000, max_salary: 3000000, company_type: "Product" },
  { role: "Product Manager", city: "Mumbai", experience_range: "6-8", min_salary: 1800000, median_salary: 3000000, max_salary: 4800000, company_type: "Product" },
]

salary_data.each do |data|
  SalaryBenchmark.find_or_create_by!(
    role: data[:role],
    city: data[:city],
    experience_range: data[:experience_range],
    company_type: data[:company_type]
  ) do |sb|
    sb.min_salary = data[:min_salary]
    sb.median_salary = data[:median_salary]
    sb.max_salary = data[:max_salary]
  end
end
puts "Created #{SalaryBenchmark.count} salary benchmarks"

# Skills
puts "Seeding skills..."

skills_data = [
  # Programming Languages
  { name: "JavaScript", category: "Programming Language", demand_index: 9.5, salary_uplift_index: 7.0, learning_difficulty_index: 4.0 },
  { name: "TypeScript", category: "Programming Language", demand_index: 9.0, salary_uplift_index: 8.0, learning_difficulty_index: 5.0 },
  { name: "Python", category: "Programming Language", demand_index: 9.5, salary_uplift_index: 8.5, learning_difficulty_index: 3.0 },
  { name: "Java", category: "Programming Language", demand_index: 8.5, salary_uplift_index: 7.5, learning_difficulty_index: 6.0 },
  { name: "Go", category: "Programming Language", demand_index: 7.5, salary_uplift_index: 9.0, learning_difficulty_index: 6.0 },
  { name: "Rust", category: "Programming Language", demand_index: 6.0, salary_uplift_index: 9.5, learning_difficulty_index: 8.0 },
  { name: "Ruby", category: "Programming Language", demand_index: 5.0, salary_uplift_index: 7.0, learning_difficulty_index: 3.5 },
  { name: "C#", category: "Programming Language", demand_index: 7.0, salary_uplift_index: 7.0, learning_difficulty_index: 5.5 },
  { name: "C++", category: "Programming Language", demand_index: 6.5, salary_uplift_index: 8.0, learning_difficulty_index: 8.0 },
  { name: "SQL", category: "Programming Language", demand_index: 9.0, salary_uplift_index: 5.0, learning_difficulty_index: 3.0 },

  # Frontend
  { name: "React", category: "Frontend Framework", demand_index: 9.5, salary_uplift_index: 8.0, learning_difficulty_index: 5.0 },
  { name: "Angular", category: "Frontend Framework", demand_index: 7.0, salary_uplift_index: 7.0, learning_difficulty_index: 7.0 },
  { name: "Vue.js", category: "Frontend Framework", demand_index: 6.5, salary_uplift_index: 7.5, learning_difficulty_index: 4.0 },
  { name: "Next.js", category: "Frontend Framework", demand_index: 8.5, salary_uplift_index: 8.5, learning_difficulty_index: 5.5 },
  { name: "HTML/CSS", category: "Frontend", demand_index: 8.0, salary_uplift_index: 3.0, learning_difficulty_index: 2.0 },
  { name: "Tailwind CSS", category: "Frontend", demand_index: 8.0, salary_uplift_index: 5.0, learning_difficulty_index: 2.5 },

  # Backend
  { name: "Node.js", category: "Backend Framework", demand_index: 9.0, salary_uplift_index: 7.5, learning_difficulty_index: 4.5 },
  { name: "Express.js", category: "Backend Framework", demand_index: 8.0, salary_uplift_index: 6.5, learning_difficulty_index: 3.5 },
  { name: "Django", category: "Backend Framework", demand_index: 7.0, salary_uplift_index: 7.5, learning_difficulty_index: 5.0 },
  { name: "Spring Boot", category: "Backend Framework", demand_index: 8.0, salary_uplift_index: 8.0, learning_difficulty_index: 7.0 },
  { name: "Ruby on Rails", category: "Backend Framework", demand_index: 4.5, salary_uplift_index: 7.0, learning_difficulty_index: 4.0 },
  { name: "FastAPI", category: "Backend Framework", demand_index: 7.5, salary_uplift_index: 8.0, learning_difficulty_index: 4.0 },
  { name: "GraphQL", category: "Backend", demand_index: 7.0, salary_uplift_index: 7.5, learning_difficulty_index: 5.5 },
  { name: "REST APIs", category: "Backend", demand_index: 9.0, salary_uplift_index: 5.0, learning_difficulty_index: 3.0 },

  # Cloud & DevOps
  { name: "AWS", category: "Cloud Platform", demand_index: 9.5, salary_uplift_index: 9.0, learning_difficulty_index: 7.0 },
  { name: "Azure", category: "Cloud Platform", demand_index: 7.5, salary_uplift_index: 8.5, learning_difficulty_index: 7.0 },
  { name: "GCP", category: "Cloud Platform", demand_index: 7.0, salary_uplift_index: 8.5, learning_difficulty_index: 7.0 },
  { name: "Docker", category: "DevOps", demand_index: 9.0, salary_uplift_index: 7.5, learning_difficulty_index: 4.5 },
  { name: "Kubernetes", category: "DevOps", demand_index: 8.5, salary_uplift_index: 9.0, learning_difficulty_index: 7.5 },
  { name: "Terraform", category: "DevOps", demand_index: 8.0, salary_uplift_index: 8.5, learning_difficulty_index: 6.0 },
  { name: "Jenkins", category: "DevOps", demand_index: 7.0, salary_uplift_index: 6.0, learning_difficulty_index: 5.0 },
  { name: "GitHub Actions", category: "DevOps", demand_index: 8.0, salary_uplift_index: 6.0, learning_difficulty_index: 3.5 },
  { name: "CI/CD", category: "DevOps", demand_index: 8.5, salary_uplift_index: 7.0, learning_difficulty_index: 5.0 },
  { name: "Linux", category: "DevOps", demand_index: 8.5, salary_uplift_index: 6.0, learning_difficulty_index: 5.0 },

  # Databases
  { name: "PostgreSQL", category: "Database", demand_index: 8.5, salary_uplift_index: 7.0, learning_difficulty_index: 5.0 },
  { name: "MongoDB", category: "Database", demand_index: 7.5, salary_uplift_index: 6.5, learning_difficulty_index: 4.0 },
  { name: "Redis", category: "Database", demand_index: 7.5, salary_uplift_index: 6.5, learning_difficulty_index: 3.5 },
  { name: "MySQL", category: "Database", demand_index: 7.5, salary_uplift_index: 5.5, learning_difficulty_index: 4.0 },
  { name: "Elasticsearch", category: "Database", demand_index: 6.5, salary_uplift_index: 7.5, learning_difficulty_index: 6.0 },

  # Data & ML
  { name: "Machine Learning", category: "Data Science", demand_index: 8.5, salary_uplift_index: 9.5, learning_difficulty_index: 8.0 },
  { name: "TensorFlow", category: "Data Science", demand_index: 7.0, salary_uplift_index: 9.0, learning_difficulty_index: 7.5 },
  { name: "PyTorch", category: "Data Science", demand_index: 7.5, salary_uplift_index: 9.0, learning_difficulty_index: 7.5 },
  { name: "Pandas", category: "Data Science", demand_index: 8.0, salary_uplift_index: 6.5, learning_difficulty_index: 3.5 },
  { name: "Power BI", category: "Data Analytics", demand_index: 7.5, salary_uplift_index: 6.0, learning_difficulty_index: 3.5 },
  { name: "Tableau", category: "Data Analytics", demand_index: 7.0, salary_uplift_index: 6.0, learning_difficulty_index: 3.5 },
  { name: "Apache Spark", category: "Data Engineering", demand_index: 7.0, salary_uplift_index: 8.5, learning_difficulty_index: 7.0 },
  { name: "Kafka", category: "Data Engineering", demand_index: 7.5, salary_uplift_index: 8.0, learning_difficulty_index: 6.5 },

  # Testing
  { name: "Selenium", category: "Testing", demand_index: 7.0, salary_uplift_index: 5.0, learning_difficulty_index: 4.0 },
  { name: "Cypress", category: "Testing", demand_index: 7.5, salary_uplift_index: 6.0, learning_difficulty_index: 3.5 },
  { name: "Jest", category: "Testing", demand_index: 8.0, salary_uplift_index: 5.5, learning_difficulty_index: 3.0 },
  { name: "JUnit", category: "Testing", demand_index: 7.0, salary_uplift_index: 5.0, learning_difficulty_index: 3.5 },
  { name: "Postman", category: "Testing", demand_index: 8.0, salary_uplift_index: 4.0, learning_difficulty_index: 2.0 },

  # Mobile
  { name: "React Native", category: "Mobile", demand_index: 7.5, salary_uplift_index: 7.5, learning_difficulty_index: 5.0 },
  { name: "Flutter", category: "Mobile", demand_index: 7.0, salary_uplift_index: 7.5, learning_difficulty_index: 5.5 },
  { name: "Swift", category: "Mobile", demand_index: 6.0, salary_uplift_index: 8.0, learning_difficulty_index: 6.0 },
  { name: "Kotlin", category: "Mobile", demand_index: 6.5, salary_uplift_index: 7.5, learning_difficulty_index: 5.5 },

  # Other
  { name: "Git", category: "Version Control", demand_index: 9.5, salary_uplift_index: 3.0, learning_difficulty_index: 3.0 },
  { name: "Agile/Scrum", category: "Methodology", demand_index: 8.0, salary_uplift_index: 4.0, learning_difficulty_index: 2.5 },
  { name: "System Design", category: "Architecture", demand_index: 8.5, salary_uplift_index: 9.0, learning_difficulty_index: 8.0 },
  { name: "Microservices", category: "Architecture", demand_index: 8.0, salary_uplift_index: 8.0, learning_difficulty_index: 7.0 },
]

skills_data.each do |data|
  Skill.find_or_create_by!(name: data[:name]) do |skill|
    skill.category = data[:category]
    skill.demand_index = data[:demand_index]
    skill.salary_uplift_index = data[:salary_uplift_index]
    skill.learning_difficulty_index = data[:learning_difficulty_index]
  end
end
puts "Created #{Skill.count} skills"

# Role-Skill Mappings
puts "Seeding role-skill mappings..."

role_skill_data = {
  "Software Developer" => {
    "JavaScript" => 0.8, "Python" => 0.7, "Java" => 0.7, "SQL" => 0.8,
    "Git" => 0.9, "REST APIs" => 0.8, "Docker" => 0.6, "PostgreSQL" => 0.7,
    "CI/CD" => 0.5, "Linux" => 0.6, "System Design" => 0.5, "Agile/Scrum" => 0.7
  },
  "Frontend Developer" => {
    "JavaScript" => 0.95, "TypeScript" => 0.85, "React" => 0.9, "HTML/CSS" => 0.95,
    "Next.js" => 0.7, "Tailwind CSS" => 0.7, "Git" => 0.9, "REST APIs" => 0.7,
    "Vue.js" => 0.5, "Jest" => 0.6, "Cypress" => 0.5, "Agile/Scrum" => 0.6
  },
  "Backend Developer" => {
    "Python" => 0.7, "Java" => 0.7, "Node.js" => 0.8, "SQL" => 0.9,
    "PostgreSQL" => 0.8, "REST APIs" => 0.9, "Docker" => 0.7, "Git" => 0.9,
    "Redis" => 0.6, "CI/CD" => 0.6, "System Design" => 0.6, "Microservices" => 0.5,
    "GraphQL" => 0.5, "Linux" => 0.7
  },
  "Full Stack Developer" => {
    "JavaScript" => 0.9, "TypeScript" => 0.8, "React" => 0.85, "Node.js" => 0.85,
    "SQL" => 0.8, "PostgreSQL" => 0.7, "REST APIs" => 0.85, "Docker" => 0.6,
    "Git" => 0.9, "HTML/CSS" => 0.8, "Next.js" => 0.6, "MongoDB" => 0.5,
    "CI/CD" => 0.5, "Agile/Scrum" => 0.6
  },
  "QA Engineer" => {
    "Selenium" => 0.9, "Cypress" => 0.7, "Jest" => 0.6, "JUnit" => 0.6,
    "Postman" => 0.85, "SQL" => 0.7, "Git" => 0.8, "JavaScript" => 0.6,
    "Python" => 0.5, "CI/CD" => 0.6, "Docker" => 0.4, "Agile/Scrum" => 0.8,
    "REST APIs" => 0.7
  },
  "Data Analyst" => {
    "SQL" => 0.95, "Python" => 0.8, "Pandas" => 0.85, "Power BI" => 0.7,
    "Tableau" => 0.7, "Excel" => 0.8, "Git" => 0.5, "PostgreSQL" => 0.6,
    "Machine Learning" => 0.4, "Agile/Scrum" => 0.5
  },
  "Data Scientist" => {
    "Python" => 0.95, "Machine Learning" => 0.9, "SQL" => 0.8, "TensorFlow" => 0.7,
    "PyTorch" => 0.7, "Pandas" => 0.9, "Apache Spark" => 0.5, "Git" => 0.7,
    "Docker" => 0.5, "AWS" => 0.5, "System Design" => 0.4
  },
  "DevOps Engineer" => {
    "AWS" => 0.9, "Docker" => 0.95, "Kubernetes" => 0.85, "Terraform" => 0.8,
    "CI/CD" => 0.9, "Linux" => 0.9, "Git" => 0.9, "Python" => 0.6,
    "Jenkins" => 0.6, "GitHub Actions" => 0.7, "Microservices" => 0.6,
    "Kafka" => 0.4, "Elasticsearch" => 0.4
  },
  "Product Manager" => {
    "SQL" => 0.6, "Agile/Scrum" => 0.95, "System Design" => 0.5,
    "REST APIs" => 0.4, "Git" => 0.3
  }
}

role_skill_data.each do |role, skills|
  skills.each do |skill_name, weight|
    skill = Skill.find_by(name: skill_name)
    next unless skill

    RoleSkillMapping.find_or_create_by!(role: role, skill: skill) do |mapping|
      mapping.importance_weight = weight
    end
  end
end
puts "Created #{RoleSkillMapping.count} role-skill mappings"

puts "Seeding complete!"

# Interview Prep Categories & Lessons
puts "Seeding interview prep categories and lessons..."

system_design = PrepCategory.find_or_create_by!(slug: "system-design") do |c|
  c.name = "System Design (HLD,LLD)"
  c.description = "Master scalable Architecture & APIs. Learn to design large-scale distributed systems."
  c.icon_name = "server"
  c.color_class = "cyan"
  c.position = 1
  c.difficulty_level = "Advanced"
  c.estimated_hours = 24
end

dsa = PrepCategory.find_or_create_by!(slug: "dsa") do |c|
  c.name = "Data Structures & Algo"
  c.description = "Arrays, Trees, Graphs & Dynamic Programming. Build strong problem-solving foundations."
  c.icon_name = "code"
  c.color_class = "green"
  c.position = 2
  c.difficulty_level = "Intermediate"
  c.estimated_hours = 30
end

behavioral = PrepCategory.find_or_create_by!(slug: "behavioral") do |c|
  c.name = "Behavioral & L/L/T"
  c.description = "Crack behavioral interviews with STAR method. Leadership, conflict resolution & more."
  c.icon_name = "users"
  c.color_class = "purple"
  c.position = 3
  c.difficulty_level = "Beginner"
  c.estimated_hours = 12
end

mock = PrepCategory.find_or_create_by!(slug: "mock-interviews") do |c|
  c.name = "Mock Interviews"
  c.description = "Practice with realistic interview scenarios. Build confidence for the real thing."
  c.icon_name = "video"
  c.color_class = "orange"
  c.position = 4
  c.difficulty_level = "Mixed"
  c.estimated_hours = 10
end

# System Design Lessons (12)
sd_lessons = [
  { title: "System Design - HLD", topic: "Load Balancing & High Availability Strategies", duration_minutes: 45, difficulty_label: "L8", position: 1,
    content_data: { "sections" => [{ "title" => "Introduction to High-Level Design", "body" => "High-Level Design (HLD) focuses on the overall system architecture. You'll learn to break down complex systems into components, define their interactions, and make trade-off decisions around scalability, availability, and consistency." }, { "title" => "Load Balancing Strategies", "body" => "Explore different load balancing algorithms including Round Robin, Least Connections, and Consistent Hashing. Understand when to use L4 vs L7 load balancers and how to design for failover." }, { "title" => "High Availability Patterns", "body" => "Learn about redundancy, replication, and failover mechanisms. Understand active-passive vs active-active configurations, health checks, and circuit breaker patterns." }], "key_points" => ["Always start with requirements clarification", "Consider both functional and non-functional requirements", "Draw the high-level architecture before diving into details", "Discuss trade-offs explicitly"] } },
  { title: "Designing a URL Shortener", topic: "Hashing, Base62 encoding, Database design", duration_minutes: 40, difficulty_label: "L6", position: 2,
    content_data: { "sections" => [{ "title" => "Requirements & Estimation", "body" => "Define functional requirements (shorten URL, redirect, analytics) and estimate scale: 100M URLs/month, 10:1 read/write ratio." }, { "title" => "Database & Encoding", "body" => "Use Base62 encoding for short codes. Compare SQL vs NoSQL for storage. Implement counter-based vs hash-based ID generation." }], "key_points" => ["Calculate storage and bandwidth estimates", "Discuss cache strategy for hot URLs", "Handle collision in hash-based approaches"] } },
  { title: "Designing a Chat System", topic: "WebSockets, Message queues, Presence", duration_minutes: 50, difficulty_label: "L8", position: 3,
    content_data: { "sections" => [{ "title" => "Real-time Communication", "body" => "Compare WebSocket, Long Polling, and Server-Sent Events. Design connection management and message delivery guarantees." }], "key_points" => ["WebSockets for bidirectional real-time communication", "Message ordering and delivery guarantees", "Presence management and online status"] } },
  { title: "Designing a News Feed", topic: "Fan-out, Ranking algorithms, Caching", duration_minutes: 45, difficulty_label: "L7", position: 4,
    content_data: { "sections" => [{ "title" => "Feed Generation", "body" => "Compare fan-out-on-write vs fan-out-on-read approaches. Design ranking algorithms that balance recency, relevance, and engagement." }], "key_points" => ["Fan-out-on-write for users with few friends", "Fan-out-on-read for celebrity accounts", "Cache frequently accessed feeds"] } },
  { title: "Designing a Rate Limiter", topic: "Token bucket, Sliding window, Distributed limiting", duration_minutes: 35, difficulty_label: "L6", position: 5,
    content_data: { "sections" => [{ "title" => "Rate Limiting Algorithms", "body" => "Explore token bucket, leaking bucket, fixed window, sliding window log, and sliding window counter algorithms with their trade-offs." }], "key_points" => ["Choose algorithm based on precision vs memory trade-off", "Use Redis for distributed rate limiting", "Consider rate limiting at multiple levels"] } },
  { title: "Designing an E-commerce Platform", topic: "Inventory, Payments, Order management", duration_minutes: 55, difficulty_label: "L9", position: 6,
    content_data: { "sections" => [{ "title" => "Core Components", "body" => "Design product catalog, shopping cart, order management, payment processing, and inventory management with eventual consistency." }], "key_points" => ["Handle inventory race conditions", "Implement saga pattern for distributed transactions", "Design for peak traffic (flash sales)"] } },
  { title: "Database Sharding & Partitioning", topic: "Horizontal scaling, Consistent hashing", duration_minutes: 40, difficulty_label: "L7", position: 7,
    content_data: { "sections" => [{ "title" => "Sharding Strategies", "body" => "Compare range-based, hash-based, and directory-based sharding. Understand resharding challenges and consistent hashing." }], "key_points" => ["Choose shard key carefully", "Plan for cross-shard queries", "Consistent hashing minimizes data movement"] } },
  { title: "Caching Strategies Deep Dive", topic: "Cache-aside, Write-through, CDN", duration_minutes: 35, difficulty_label: "L6", position: 8,
    content_data: { "sections" => [{ "title" => "Caching Patterns", "body" => "Learn cache-aside, read-through, write-through, write-behind, and refresh-ahead patterns. Understand cache invalidation strategies." }], "key_points" => ["Cache invalidation is one of the hardest problems", "Use TTL as a safety net", "Monitor cache hit ratios"] } },
  { title: "Designing a Search Engine", topic: "Inverted index, Ranking, Crawling", duration_minutes: 50, difficulty_label: "L9", position: 9,
    content_data: { "sections" => [{ "title" => "Search Architecture", "body" => "Design web crawler, indexing pipeline, query processing, and ranking engine. Understand inverted indexes and TF-IDF scoring." }], "key_points" => ["Inverted index is the core data structure", "PageRank for authority-based ranking", "Handle query spelling correction and suggestions"] } },
  { title: "Microservices Architecture", topic: "Service mesh, API gateway, Event-driven", duration_minutes: 45, difficulty_label: "L8", position: 10,
    content_data: { "sections" => [{ "title" => "Microservices Patterns", "body" => "Learn service decomposition, API gateway pattern, service discovery, circuit breaker, and saga pattern for distributed transactions." }], "key_points" => ["Define clear service boundaries", "Use API gateway for cross-cutting concerns", "Implement circuit breakers for resilience"] } },
  { title: "Designing a Video Streaming Platform", topic: "CDN, Transcoding, Adaptive streaming", duration_minutes: 50, difficulty_label: "L9", position: 11,
    content_data: { "sections" => [{ "title" => "Video Pipeline", "body" => "Design video upload, transcoding pipeline, content delivery network, and adaptive bitrate streaming with HLS/DASH." }], "key_points" => ["Transcode to multiple resolutions", "Use CDN for global distribution", "Implement adaptive bitrate streaming"] } },
  { title: "LLD: Parking Lot System", topic: "OOP design, SOLID principles, Class diagrams", duration_minutes: 40, difficulty_label: "L6", position: 12,
    content_data: { "sections" => [{ "title" => "Low-Level Design Approach", "body" => "Apply SOLID principles to design a parking lot system. Define classes, interfaces, and their relationships using UML diagrams." }], "key_points" => ["Start with use cases and actors", "Apply SOLID principles throughout", "Use design patterns (Strategy, Observer, Factory)"] } }
]

sd_lessons.each do |data|
  PrepLesson.find_or_create_by!(prep_category: system_design, title: data[:title]) do |l|
    l.assign_attributes(data.except(:title))
  end
end

# DSA Lessons (15)
dsa_lessons = [
  { title: "Arrays & Two Pointer Technique", topic: "Array manipulation, Sliding window", duration_minutes: 40, difficulty_label: "L4", position: 1,
    content_data: { "sections" => [{ "title" => "Two Pointer Fundamentals", "body" => "Master the two-pointer technique for solving array problems efficiently. Learn when to use same-direction vs opposite-direction pointers." }], "key_points" => ["Two pointers reduce O(n^2) to O(n)", "Sliding window for subarray problems", "Sort first when order doesn't matter"] } },
  { title: "Linked Lists Mastery", topic: "Reversal, Cycle detection, Merge", duration_minutes: 35, difficulty_label: "L4", position: 2,
    content_data: { "sections" => [{ "title" => "Core Operations", "body" => "Practice linked list reversal, Floyd's cycle detection, merging sorted lists, and finding intersection points." }], "key_points" => ["Draw the pointer changes before coding", "Use dummy head node to simplify edge cases", "Fast & slow pointer for cycle detection"] } },
  { title: "Stacks & Queues", topic: "Monotonic stack, BFS applications", duration_minutes: 35, difficulty_label: "L5", position: 3,
    content_data: { "sections" => [{ "title" => "Advanced Stack Patterns", "body" => "Learn monotonic stack for next greater element problems, evaluate expressions, and implement queue using stacks." }], "key_points" => ["Monotonic stack for next greater/smaller element", "Stack for matching parentheses and expression evaluation", "Queue for BFS traversal"] } },
  { title: "Hash Maps & Hash Sets", topic: "Collision handling, Frequency counting", duration_minutes: 30, difficulty_label: "L4", position: 4,
    content_data: { "sections" => [{ "title" => "Hash Map Patterns", "body" => "Use hash maps for frequency counting, two-sum pattern, grouping, and implementing LRU cache." }], "key_points" => ["Hash maps provide O(1) average lookup", "Use for counting and grouping problems", "Combine with other data structures for complex solutions"] } },
  { title: "Binary Trees & BST", topic: "Traversals, BST operations, Balance", duration_minutes: 45, difficulty_label: "L6", position: 5,
    content_data: { "sections" => [{ "title" => "Tree Traversal Patterns", "body" => "Master DFS (preorder, inorder, postorder) and BFS traversals. Solve problems using recursive and iterative approaches." }], "key_points" => ["Inorder traversal of BST gives sorted order", "Use level-order for breadth-first problems", "Think recursively: solve for root, recurse for subtrees"] } },
  { title: "Heaps & Priority Queues", topic: "Top-K problems, Merge K sorted lists", duration_minutes: 35, difficulty_label: "L6", position: 6,
    content_data: { "sections" => [{ "title" => "Heap Applications", "body" => "Use heaps for top-K elements, running median, merge K sorted arrays, and task scheduling problems." }], "key_points" => ["Min-heap for K largest, max-heap for K smallest", "Heap operations are O(log n)", "Use for streaming/online algorithms"] } },
  { title: "Graph Traversal: BFS & DFS", topic: "Connected components, Topological sort", duration_minutes: 45, difficulty_label: "L7", position: 7,
    content_data: { "sections" => [{ "title" => "Graph Algorithms", "body" => "Implement BFS and DFS for graphs. Solve connected components, cycle detection, and topological sorting problems." }], "key_points" => ["BFS for shortest path in unweighted graphs", "DFS for cycle detection and topological sort", "Use visited set to avoid infinite loops"] } },
  { title: "Dynamic Programming Fundamentals", topic: "Memoization, Tabulation, Common patterns", duration_minutes: 50, difficulty_label: "L7", position: 8,
    content_data: { "sections" => [{ "title" => "DP Thinking Framework", "body" => "Learn to identify DP problems, define states and transitions, and implement both top-down (memoization) and bottom-up (tabulation) solutions." }], "key_points" => ["Identify overlapping subproblems", "Define the state clearly", "Start with brute force, then optimize with memoization"] } },
  { title: "DP: Knapsack & Subset Problems", topic: "0/1 Knapsack, Subset sum, Partition", duration_minutes: 45, difficulty_label: "L7", position: 9,
    content_data: { "sections" => [{ "title" => "Knapsack Family", "body" => "Solve 0/1 knapsack, unbounded knapsack, subset sum, and partition problems. Learn space optimization techniques." }], "key_points" => ["0/1 knapsack: include or exclude each item", "Space optimize from 2D to 1D array", "Subset sum is a special case of knapsack"] } },
  { title: "DP: String Problems", topic: "LCS, Edit distance, Palindromes", duration_minutes: 45, difficulty_label: "L8", position: 10,
    content_data: { "sections" => [{ "title" => "String DP Patterns", "body" => "Solve longest common subsequence, edit distance, longest palindromic subsequence, and regex matching using DP." }], "key_points" => ["Two-string DP: use 2D table indexed by both strings", "Edit distance has 3 operations: insert, delete, replace", "Palindrome DP: expand from center or use interval DP"] } },
  { title: "Sorting & Searching Algorithms", topic: "Binary search variations, QuickSort", duration_minutes: 40, difficulty_label: "L5", position: 11,
    content_data: { "sections" => [{ "title" => "Binary Search Mastery", "body" => "Go beyond basic binary search: search in rotated arrays, find first/last occurrence, search in 2D matrix, and binary search on answer." }], "key_points" => ["Binary search on answer for optimization problems", "Handle edge cases in rotated array search", "Know when to use lower_bound vs upper_bound"] } },
  { title: "Greedy Algorithms", topic: "Interval scheduling, Huffman coding", duration_minutes: 35, difficulty_label: "L6", position: 12,
    content_data: { "sections" => [{ "title" => "Greedy Strategy", "body" => "Learn to prove greedy choice property. Solve interval scheduling, activity selection, and optimal merge pattern problems." }], "key_points" => ["Prove greedy choice leads to optimal solution", "Sort by end time for interval scheduling", "Greedy doesn't always work - verify with counterexamples"] } },
  { title: "Backtracking Patterns", topic: "Permutations, Combinations, N-Queens", duration_minutes: 40, difficulty_label: "L7", position: 13,
    content_data: { "sections" => [{ "title" => "Backtracking Framework", "body" => "Learn the backtracking template: make choice, explore, undo choice. Apply to permutations, combinations, sudoku, and N-Queens." }], "key_points" => ["Use a template: choose, explore, unchoose", "Prune early to improve performance", "Track state with visited array or bitmask"] } },
  { title: "Trie & Advanced Data Structures", topic: "Prefix trees, Segment trees, Union-Find", duration_minutes: 40, difficulty_label: "L8", position: 14,
    content_data: { "sections" => [{ "title" => "Trie Operations", "body" => "Implement trie for prefix search, autocomplete, and word dictionary. Introduction to segment trees and union-find for range queries and connectivity." }], "key_points" => ["Trie for prefix-based search problems", "Union-Find for connected components", "Segment tree for range queries"] } },
  { title: "Bit Manipulation Techniques", topic: "XOR tricks, Bitmask DP", duration_minutes: 30, difficulty_label: "L6", position: 15,
    content_data: { "sections" => [{ "title" => "Bit Tricks", "body" => "Master common bit manipulation techniques: check/set/clear bits, XOR properties, counting set bits, and bitmask DP." }], "key_points" => ["XOR: a^a=0, a^0=a for finding unique elements", "n&(n-1) removes lowest set bit", "Bitmask DP for subset enumeration"] } }
]

dsa_lessons.each do |data|
  PrepLesson.find_or_create_by!(prep_category: dsa, title: data[:title]) do |l|
    l.assign_attributes(data.except(:title))
  end
end

# Behavioral Lessons (8)
behavioral_lessons = [
  { title: "STAR Method Mastery", topic: "Structuring behavioral answers", duration_minutes: 30, difficulty_label: "L3", position: 1,
    content_data: { "sections" => [{ "title" => "The STAR Framework", "body" => "Learn to structure your behavioral answers using Situation, Task, Action, Result. Practice crafting compelling narratives that highlight your impact." }], "key_points" => ["Keep Situation and Task brief (20% of answer)", "Focus most time on Action (50%)", "Quantify Results whenever possible"] } },
  { title: "Leadership & Influence", topic: "Leading without authority, Mentoring", duration_minutes: 35, difficulty_label: "L5", position: 2,
    content_data: { "sections" => [{ "title" => "Demonstrating Leadership", "body" => "Prepare stories about leading projects, mentoring team members, driving technical decisions, and influencing stakeholders without formal authority." }], "key_points" => ["Show initiative and ownership", "Demonstrate impact beyond your role", "Highlight how you grew others"] } },
  { title: "Conflict Resolution", topic: "Handling disagreements, Difficult conversations", duration_minutes: 30, difficulty_label: "L5", position: 3,
    content_data: { "sections" => [{ "title" => "Navigating Conflicts", "body" => "Learn frameworks for discussing conflicts constructively. Prepare stories about disagreements with teammates, managers, or cross-functional partners." }], "key_points" => ["Focus on the problem, not the person", "Show empathy and active listening", "Highlight the positive outcome"] } },
  { title: "Tell Me About Yourself", topic: "Elevator pitch, Career narrative", duration_minutes: 25, difficulty_label: "L2", position: 4,
    content_data: { "sections" => [{ "title" => "Crafting Your Narrative", "body" => "Build a compelling 2-minute career story that connects your past experience, current role, and future goals to the position you're interviewing for." }], "key_points" => ["Keep it under 2 minutes", "Connect past-present-future", "Tailor to the specific role"] } },
  { title: "Why This Company?", topic: "Research, Alignment, Motivation", duration_minutes: 25, difficulty_label: "L3", position: 5,
    content_data: { "sections" => [{ "title" => "Showing Genuine Interest", "body" => "Research company culture, recent news, products, and tech stack. Align your interests and career goals with the company's mission and opportunities." }], "key_points" => ["Research beyond the job description", "Connect your goals with company mission", "Show knowledge of recent company achievements"] } },
  { title: "Failure & Learning Stories", topic: "Growth mindset, Accountability", duration_minutes: 30, difficulty_label: "L4", position: 6,
    content_data: { "sections" => [{ "title" => "Discussing Failures", "body" => "Prepare stories about failures, mistakes, and setbacks that demonstrate accountability, learning, and growth. Show how you applied lessons learned." }], "key_points" => ["Own the failure - don't blame others", "Focus on what you learned", "Show how you applied the lesson afterwards"] } },
  { title: "Teamwork & Collaboration", topic: "Cross-functional work, Remote collaboration", duration_minutes: 30, difficulty_label: "L4", position: 7,
    content_data: { "sections" => [{ "title" => "Collaborative Excellence", "body" => "Prepare stories demonstrating effective collaboration with designers, product managers, and other engineering teams. Highlight communication and coordination skills." }], "key_points" => ["Show you value diverse perspectives", "Demonstrate proactive communication", "Highlight your role in team success"] } },
  { title: "Salary Negotiation Strategies", topic: "Offer evaluation, Counter-offers", duration_minutes: 35, difficulty_label: "L5", position: 8,
    content_data: { "sections" => [{ "title" => "Negotiation Framework", "body" => "Learn frameworks for evaluating offers, timing your negotiation, presenting counter-offers, and negotiating beyond base salary (equity, signing bonus, WFH)." }], "key_points" => ["Never give a number first", "Research market rates thoroughly", "Negotiate the total package, not just base salary"] } }
]

behavioral_lessons.each do |data|
  PrepLesson.find_or_create_by!(prep_category: behavioral, title: data[:title]) do |l|
    l.assign_attributes(data.except(:title))
  end
end

# Mock Interview Lessons (6)
mock_lessons = [
  { title: "System Design Mock: Design Twitter", topic: "Full mock interview simulation", duration_minutes: 60, difficulty_label: "L8", position: 1,
    content_data: { "sections" => [{ "title" => "Mock Interview Setup", "body" => "Simulate a 45-minute system design interview for designing Twitter. Practice requirements gathering, high-level design, deep dives, and handling follow-up questions." }], "key_points" => ["Spend first 5 min on requirements", "Draw the architecture clearly", "Discuss trade-offs at each decision point"] } },
  { title: "DSA Mock: Array & String Problems", topic: "Timed coding practice with industry questions", duration_minutes: 45, difficulty_label: "L6", position: 2,
    content_data: { "sections" => [{ "title" => "Coding Interview Simulation", "body" => "Practice solving 2-3 coding problems in 45 minutes. Focus on thinking out loud, writing clean code, and handling edge cases." }], "key_points" => ["Think out loud throughout", "Clarify constraints before coding", "Test with examples and edge cases"] } },
  { title: "Behavioral Mock: Amazon LP", topic: "Leadership Principles deep-dive practice", duration_minutes: 40, difficulty_label: "L5", position: 3,
    content_data: { "sections" => [{ "title" => "Amazon Leadership Principles", "body" => "Practice answering behavioral questions mapped to Amazon's 16 Leadership Principles. Prepare 2-3 stories for each principle." }], "key_points" => ["Map your stories to specific LPs", "Use concrete metrics and outcomes", "Practice pivot between stories smoothly"] } },
  { title: "Full Loop Mock: Frontend Engineer", topic: "Complete interview day simulation", duration_minutes: 90, difficulty_label: "L7", position: 4,
    content_data: { "sections" => [{ "title" => "Full Loop Simulation", "body" => "Simulate a complete interview loop: coding round, system design round, behavioral round, and hiring manager round. Practice transitions and maintaining energy." }], "key_points" => ["Manage your energy across rounds", "Each round is independent - reset mentally", "Ask clarifying questions in every round"] } },
  { title: "System Design Mock: Design Uber", topic: "Geo-spatial systems & real-time matching", duration_minutes: 60, difficulty_label: "L9", position: 5,
    content_data: { "sections" => [{ "title" => "Ride-Sharing System Design", "body" => "Design Uber's core system: rider-driver matching, real-time location tracking, pricing engine, and trip management." }], "key_points" => ["Geospatial indexing with QuadTree/GeoHash", "Real-time location updates with WebSockets", "Supply-demand based dynamic pricing"] } },
  { title: "DSA Mock: Graph & DP Problems", topic: "Advanced problem-solving practice", duration_minutes: 50, difficulty_label: "L8", position: 6,
    content_data: { "sections" => [{ "title" => "Advanced Coding Practice", "body" => "Tackle medium-hard graph and dynamic programming problems. Practice identifying patterns and optimizing solutions within time constraints." }], "key_points" => ["Identify the problem pattern first", "Start with brute force, then optimize", "Communicate your thought process clearly"] } }
]

mock_lessons.each do |data|
  PrepLesson.find_or_create_by!(prep_category: mock, title: data[:title]) do |l|
    l.assign_attributes(data.except(:title))
  end
end

puts "Created #{PrepCategory.count} prep categories with #{PrepLesson.count} lessons"
