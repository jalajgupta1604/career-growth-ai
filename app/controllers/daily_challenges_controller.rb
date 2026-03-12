class DailyChallengesController < ApplicationController
  before_action :authenticate_user!

  def show
    service = DailyChallengeService.new(current_user)
    @challenge = service.today_challenge
    @streak = service.streak_data
    @attempt = @challenge.attempt_by(current_user)
    @recent_attempts = service.recent_attempts
  end

  def submit
    service = DailyChallengeService.new(current_user)
    @challenge = service.today_challenge

    if @challenge.attempted_by?(current_user)
      redirect_to daily_challenge_path, alert: "You've already completed today's challenge!"
      return
    end

    @attempt = service.submit_answer(@challenge, params[:answer])

    if @attempt
      redirect_to daily_challenge_path, notice: "Challenge completed! Score: #{@attempt.score}/10"
    else
      redirect_to daily_challenge_path, alert: "Something went wrong. Please try again."
    end
  end
end
