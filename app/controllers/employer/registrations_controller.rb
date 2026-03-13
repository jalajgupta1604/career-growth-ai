class Employer::RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.employer_profile.present?
      redirect_to employer_root_path
      return
    end
    @employer_profile = EmployerProfile.new
  end

  def create
    @employer_profile = current_user.build_employer_profile(employer_params)

    if @employer_profile.save
      @employer_profile.generate_verification_token!
      redirect_to employer_root_path, notice: "Employer profile created. Verification email sent to your company domain."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def employer_params
    params.require(:employer_profile).permit(:company_name, :company_domain, :company_size, :industry, :company_description)
  end
end
