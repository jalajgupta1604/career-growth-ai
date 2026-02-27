class CreateLessonProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prep_lesson, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.integer :time_spent_minutes, default: 0
      t.datetime :started_at
      t.datetime :completed_at
      t.jsonb :notes_data, default: {}

      t.timestamps
    end

    add_index :lesson_progresses, [:user_id, :prep_lesson_id], unique: true
  end
end
