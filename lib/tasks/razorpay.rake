namespace :razorpay do
  desc "Create monthly and yearly subscription plans on Razorpay"
  task create_plans: :environment do
    plans = [
      {
        period: "monthly",
        interval: 1,
        item: {
          name: "Career Growth AI Pro — Monthly",
          amount: 499_00,
          currency: "INR",
          description: "Full access to career reports, PDFs, and all Pro features"
        }
      },
      {
        period: "yearly",
        interval: 1,
        item: {
          name: "Career Growth AI Pro — Yearly",
          amount: 4999_00,
          currency: "INR",
          description: "Full access to career reports, PDFs, and all Pro features (save 2 months)"
        }
      }
    ]

    plans.each do |plan_data|
      plan = Razorpay::Plan.create(plan_data)
      puts "Created #{plan_data[:period]} plan: #{plan.id}"
      puts "  Add to .env: RAZORPAY_#{plan_data[:period].upcase}_PLAN_ID=#{plan.id}"
      puts
    end
  end
end
