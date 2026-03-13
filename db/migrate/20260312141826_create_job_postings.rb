class CreateJobPostings < ActiveRecord::Migration[8.0]
  def change
    create_table :job_postings do |t|
      t.string :company_name, null: false
      t.string :title, null: false
      t.text :description
      t.string :location
      t.string :job_type, default: "full_time"
      t.integer :min_salary
      t.integer :max_salary
      t.jsonb :required_skills, default: []
      t.string :experience_range
      t.integer :status, default: 0, null: false
      t.references :posted_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :job_postings, :status
  end
end
