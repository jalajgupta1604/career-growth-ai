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
