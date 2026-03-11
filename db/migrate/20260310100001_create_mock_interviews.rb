class CreateMockInterviews < ActiveRecord::Migration[8.0]
  def change
    create_table :mock_interviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :interview_type, null: false, default: "technical"
      t.string :difficulty, null: false, default: "medium"
      t.string :target_role
      t.integer :status, null: false, default: 0
      t.jsonb :questions_data, default: []
      t.jsonb :responses_data, default: []
      t.jsonb :feedback_data, default: {}
      t.float :overall_score
      t.integer :total_questions, default: 5
      t.integer :answered_questions, default: 0
      t.datetime :started_at
      t.datetime :completed_at
      t.timestamps
    end

    add_index :mock_interviews, [:user_id, :created_at]
    add_index :mock_interviews, :status
  end
end
