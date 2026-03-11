class CreateInterviewExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :interview_experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :role, null: false
      t.string :difficulty, default: "medium"
      t.string :outcome
      t.integer :rounds_count
      t.integer :overall_rating
      t.text :experience_summary
      t.jsonb :rounds_data, default: []
      t.jsonb :tags, default: []
      t.boolean :anonymous, default: true
      t.timestamps
    end

    add_index :interview_experiences, [:company_name, :role], name: "idx_interview_exp_company_role"
    add_index :interview_experiences, :difficulty
    add_index :interview_experiences, :outcome
    add_index :interview_experiences, :created_at
  end
end
