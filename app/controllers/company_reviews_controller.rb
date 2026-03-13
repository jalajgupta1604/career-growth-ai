class CompanyReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = CompanyReview.recent.includes(:user).limit(50)
    @companies = CompanyReview.distinct.pluck(:company_name).sort
  end

  def new
    @review = CompanyReview.new
  end

  def create
    @review = current_user.company_reviews.build(review_params)
    if @review.save
      redirect_to company_reviews_path, notice: "Review submitted!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @company_name = params[:id]
    @reviews = CompanyReview.for_company(@company_name).recent
    @avg_rating = CompanyReview.average_rating_for(@company_name)
  end

  private

  def review_params
    params.require(:company_review).permit(:company_name, :overall_rating, :pros, :cons, :interview_difficulty, :salary_range, :role_reviewed, :employment_status)
  end
end
