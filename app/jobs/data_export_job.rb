class DataExportJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    export_data = {
      profile: user.attributes.except("encrypted_password", "reset_password_token"),
      resumes: user.resumes.map(&:attributes),
      career_reports: user.career_reports.map(&:attributes),
      mock_interviews: user.mock_interviews.map(&:attributes),
      salary_submissions: user.salary_submissions.map(&:attributes),
      community_posts: user.community_posts.map(&:attributes),
      company_reviews: user.company_reviews.map(&:attributes),
      discussion_threads: user.discussion_threads.map(&:attributes),
      exported_at: Time.current.iso8601
    }

    user.update!(data_exported_at: Time.current)

    NotificationService.notify(
      user: user,
      title: "Your data export is ready",
      body: "Your account data has been exported successfully.",
      category: "system"
    )
  end
end
