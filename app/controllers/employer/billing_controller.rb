module Employer
  class BillingController < BaseController
    def show
      @employer = current_employer
      @plans = EmployerProfile::BILLING_PLANS
      @current_plan = @employer.billing_plan || "free"
    end
  end
end
