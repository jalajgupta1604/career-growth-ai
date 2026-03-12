class CreateReadinessScores < ActiveRecord::Migration[8.0]
  def change
    create_table :readiness_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.float :overall_score, default: 0.0
      t.jsonb :category_scores, default: {}
      t.float :mock_interview_score, default: 0.0
      t.float :lesson_score, default: 0.0
      t.float :streak_score, default: 0.0
      t.datetime :calculated_at

      t.timestamps
    end

    add_index :readiness_scores, [:user_id, :calculated_at]
  end
end
