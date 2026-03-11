class CreateJobRecommendations < ActiveRecord::Migration[8.0]
  def change
    create_table :job_listings do |t|
      t.string :title, null: false
      t.string :company_name, null: false
      t.string :location
      t.string :job_type
      t.decimal :min_salary, precision: 12, scale: 2
      t.decimal :max_salary, precision: 12, scale: 2
      t.text :description
      t.jsonb :required_skills, default: []
      t.jsonb :preferred_skills, default: []
      t.string :experience_range
      t.string :source
      t.string :source_url
      t.boolean :active, default: true
      t.datetime :posted_at
      t.timestamps
    end

    add_index :job_listings, [:title, :company_name]
    add_index :job_listings, :active
    add_index :job_listings, :location

    create_table :job_recommendations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_listing, null: false, foreign_key: true
      t.float :match_score
      t.jsonb :match_reasons, default: []
      t.jsonb :skill_matches, default: {}
      t.string :status, default: "new"
      t.datetime :viewed_at
      t.datetime :applied_at
      t.datetime :saved_at
      t.timestamps
    end

    add_index :job_recommendations, [:user_id, :job_listing_id], unique: true, name: "idx_job_recs_user_listing"
    add_index :job_recommendations, [:user_id, :match_score]
    add_index :job_recommendations, :status
  end
end
