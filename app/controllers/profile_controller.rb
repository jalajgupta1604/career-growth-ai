class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @subscription = current_user.subscription
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :role, :city, :experience_years, :current_salary, :profile_photo)
  end
end
