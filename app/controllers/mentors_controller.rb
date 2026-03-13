class MentorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @mentors = MentorProfile.available.includes(:user).recent.limit(30)
    @my_profile = current_user.mentor_profile
  end

  def create
    @profile = current_user.build_mentor_profile(mentor_params)
    if @profile.save
      redirect_to mentors_path, notice: "You're now a mentor!"
    else
      redirect_to mentors_path, alert: @profile.errors.full_messages.join(", ")
    end
  end

  def update
    @profile = current_user.mentor_profile
    if @profile&.update(mentor_params)
      redirect_to mentors_path, notice: "Profile updated."
    else
      redirect_to mentors_path, alert: "Failed to update."
    end
  end

  private

  def mentor_params
    params.require(:mentor_profile).permit(:bio, :available, :max_mentees, expertise: [])
  end
end
