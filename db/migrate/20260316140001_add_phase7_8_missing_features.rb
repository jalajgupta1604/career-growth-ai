class AddPhase78MissingFeatures < ActiveRecord::Migration[8.0]
  def change
    # Search analytics
    create_table :search_queries do |t|
      t.references :user, null: true, foreign_key: true
      t.string :query, null: false
      t.integer :results_count, default: 0
      t.string :result_type_clicked
      t.integer :result_id_clicked
      t.timestamps
    end

    add_index :search_queries, :query
    add_index :search_queries, :created_at

    # Privacy controls
    change_table :users do |t|
      t.jsonb :privacy_settings, default: {}
      t.string :health_score_risk
    end

    # Session management
    create_table :user_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :session_token, null: false
      t.string :ip_address
      t.string :user_agent
      t.string :device_type
      t.datetime :last_active_at
      t.timestamps
    end

    add_index :user_sessions, :session_token, unique: true

    # Content versioning for CMS
    create_table :content_versions do |t|
      t.references :cms_content, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :version_number, null: false
      t.text :body
      t.string :title
      t.text :change_summary
      t.timestamps
    end

    add_index :content_versions, [:cms_content_id, :version_number], unique: true

    # Hiring analytics
    change_table :employer_profiles do |t|
      t.integer :total_hires, default: 0
      t.float :avg_time_to_hire_days
      t.float :avg_cost_per_hire
    end
  end
end
