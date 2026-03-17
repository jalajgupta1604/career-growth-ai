class AddPhase78RemainingFeatures < ActiveRecord::Migration[8.0]
  def change
    # --- Phase 7: Auto-moderation ---
    add_column :community_posts, :moderation_status, :string, default: "approved", null: false
    add_column :community_posts, :flagged_keywords, :jsonb, default: []
    add_column :community_posts, :auto_moderated_at, :datetime

    add_column :discussion_threads, :moderation_status, :string, default: "approved", null: false
    add_column :discussion_replies, :moderation_status, :string, default: "approved", null: false

    # --- Phase 7: Trust scores ---
    add_column :users, :trust_score, :float, default: 50.0, null: false
    add_column :users, :trust_level, :string, default: "new", null: false
    add_column :users, :flags_received_count, :integer, default: 0, null: false
    add_column :users, :flags_given_count, :integer, default: 0, null: false
    add_column :users, :helpful_count, :integer, default: 0, null: false

    # --- Phase 7: Admin impersonation ---
    create_table :impersonation_logs do |t|
      t.references :admin, null: false, foreign_key: { to_table: :users }
      t.references :target_user, null: false, foreign_key: { to_table: :users }
      t.string :reason, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.string :ip_address
      t.timestamps
    end

    # --- Phase 8: A/B Testing ---
    create_table :experiments do |t|
      t.string :name, null: false
      t.string :description
      t.string :status, default: "draft", null: false
      t.jsonb :variants, default: [], null: false
      t.string :metric, null: false
      t.float :traffic_percentage, default: 100.0
      t.datetime :started_at
      t.datetime :ended_at
      t.jsonb :results, default: {}
      t.timestamps
    end
    add_index :experiments, :name, unique: true
    add_index :experiments, :status

    create_table :experiment_assignments do |t|
      t.references :experiment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :variant, null: false
      t.boolean :converted, default: false
      t.datetime :converted_at
      t.timestamps
    end
    add_index :experiment_assignments, [:experiment_id, :user_id], unique: true

    # --- Phase 8: Interview Scheduling ---
    create_table :interview_schedules do |t|
      t.references :job_application, null: false, foreign_key: true
      t.references :employer_profile, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.string :round_type, default: "screening", null: false
      t.datetime :scheduled_at, null: false
      t.integer :duration_minutes, default: 60
      t.string :meeting_link
      t.string :location
      t.string :status, default: "pending", null: false
      t.text :notes
      t.text :candidate_notes
      t.text :interviewer_feedback
      t.integer :rating
      t.datetime :confirmed_at
      t.datetime :completed_at
      t.datetime :cancelled_at
      t.timestamps
    end
    add_index :interview_schedules, :scheduled_at
    add_index :interview_schedules, :status

    # --- Phase 8: Offer Management ---
    create_table :job_offers do |t|
      t.references :job_application, null: false, foreign_key: true
      t.references :employer_profile, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: { to_table: :users }
      t.decimal :base_salary, precision: 12, scale: 2
      t.decimal :variable_pay, precision: 12, scale: 2
      t.decimal :equity_value, precision: 12, scale: 2
      t.string :designation
      t.string :location
      t.date :joining_date
      t.text :benefits
      t.text :additional_terms
      t.string :status, default: "draft", null: false
      t.datetime :sent_at
      t.datetime :accepted_at
      t.datetime :declined_at
      t.datetime :expires_at
      t.text :decline_reason
      t.timestamps
    end
    add_index :job_offers, :status

    # --- Phase 8: Referral Hiring & Commission ---
    create_table :hiring_referrals do |t|
      t.references :referrer, null: false, foreign_key: { to_table: :users }
      t.references :candidate, null: false, foreign_key: { to_table: :users }
      t.references :job_posting, null: false, foreign_key: true
      t.references :employer_profile, null: false, foreign_key: true
      t.string :status, default: "referred", null: false
      t.decimal :commission_amount, precision: 10, scale: 2
      t.string :commission_status, default: "pending"
      t.datetime :hired_at
      t.datetime :commission_paid_at
      t.text :notes
      t.timestamps
    end
    add_index :hiring_referrals, [:referrer_id, :candidate_id, :job_posting_id],
              unique: true, name: "idx_unique_hiring_referral"
  end
end
