class AddPersonalizationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :user_type, :string, default: "job_seeker"  # job_seeker, skill_builder, salary_negotiator
    add_column :users, :engagement_score, :float, default: 0.0
    add_column :users, :dashboard_layout, :jsonb, default: {}
    add_column :users, :notification_preferences, :jsonb, default: {}
    add_column :users, :last_active_at, :datetime
  end
end
