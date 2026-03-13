class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:q].to_s.strip
    return if @query.blank?

    @results = []
    @results += search_jobs
    @results += search_discussions
    @results += search_company_reviews
    @results += search_community
    @results += search_experiences
    @results.sort_by! { |r| -r[:relevance] }
  end

  private

  def search_jobs
    JobPosting.where("title ILIKE ? OR description ILIKE ?", "%#{@query}%", "%#{@query}%")
              .limit(5)
              .map { |j| { type: "Job", title: j.title, subtitle: j.company_name, url: job_posting_path(j), relevance: 5 } }
  end

  def search_discussions
    DiscussionThread.where("title ILIKE ?", "%#{@query}%")
                    .limit(5)
                    .map { |d| { type: "Discussion", title: d.title, subtitle: d.category, url: discussion_path(d), relevance: 4 } }
  end

  def search_company_reviews
    CompanyReview.where("company_name ILIKE ?", "%#{@query}%")
                 .limit(5)
                 .map { |r| { type: "Review", title: r.company_name, subtitle: "#{r.rating}/5", url: company_review_path(r), relevance: 3 } }
  end

  def search_community
    CommunityPost.where("content ILIKE ?", "%#{@query}%")
                 .limit(5)
                 .map { |p| { type: "Post", title: p.content.truncate(80), subtitle: p.category, url: community_index_path, relevance: 2 } }
  end

  def search_experiences
    InterviewExperience.where("company_name ILIKE ?", "%#{@query}%")
                       .limit(5)
                       .map { |e| { type: "Experience", title: "#{e.company_name} - #{e.role}", subtitle: e.difficulty, url: interview_experience_path(e), relevance: 3 } }
  end
end
