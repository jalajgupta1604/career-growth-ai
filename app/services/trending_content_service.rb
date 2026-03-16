class TrendingContentService
  def self.trending(limit: 10)
    {
      posts: trending_posts(limit),
      discussions: trending_discussions(limit),
      jobs: trending_jobs(limit),
      skills: trending_skills(limit)
    }
  end

  def self.trending_posts(limit = 5)
    CommunityPost.joins("LEFT JOIN post_likes ON post_likes.community_post_id = community_posts.id")
                 .where("community_posts.created_at > ?", 7.days.ago)
                 .group("community_posts.id")
                 .order("COUNT(post_likes.id) DESC")
                 .limit(limit)
                 .select("community_posts.*, COUNT(post_likes.id) AS likes_count")
  end

  def self.trending_discussions(limit = 5)
    DiscussionThread.joins("LEFT JOIN discussion_replies ON discussion_replies.discussion_thread_id = discussion_threads.id")
                    .where("discussion_threads.created_at > ?", 14.days.ago)
                    .group("discussion_threads.id")
                    .order("COUNT(discussion_replies.id) DESC")
                    .limit(limit)
                    .select("discussion_threads.*, COUNT(discussion_replies.id) AS replies_count")
  end

  def self.trending_jobs(limit = 5)
    JobPosting.active_listings
              .joins("LEFT JOIN job_applications ON job_applications.job_posting_id = job_postings.id")
              .group("job_postings.id")
              .order("COUNT(job_applications.id) DESC")
              .limit(limit)
              .select("job_postings.*, COUNT(job_applications.id) AS applications_count")
  end

  def self.trending_skills(limit = 10)
    SkillTrend.where("created_at > ?", 30.days.ago)
              .order(demand_score: :desc)
              .limit(limit)
  end
end
