class AddOnboardingGoalsAndPushSubscription < ActiveRecord::Migration[8.0]
  def change
    change_table :users do |t|
      t.jsonb :career_goals, default: []
      t.string :onboarding_path # job_seeker, career_growth, interview_prep, salary_negotiation
    end

    create_table :push_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :endpoint, null: false
      t.string :p256dh_key
      t.string :auth_key
      t.timestamps
    end

    add_index :push_subscriptions, :endpoint, unique: true
  end
end
