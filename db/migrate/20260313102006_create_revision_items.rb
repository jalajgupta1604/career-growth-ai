class CreateRevisionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :revision_items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source_type, null: false
      t.integer :source_id
      t.string :topic, null: false
      t.string :difficulty, default: "medium", null: false
      t.float :easiness_factor, default: 2.5, null: false
      t.integer :interval, default: 1, null: false
      t.integer :repetitions, default: 0, null: false
      t.datetime :next_review_at, null: false
      t.datetime :last_reviewed_at
      t.integer :correct_streak, default: 0, null: false
      t.integer :total_attempts, default: 0, null: false
      t.integer :correct_attempts, default: 0, null: false
      t.jsonb :question_data, default: {}, null: false
      t.jsonb :answer_data, default: {}, null: false

      t.timestamps
    end

    add_index :revision_items, [:user_id, :next_review_at]
    add_index :revision_items, [:user_id, :topic]
    add_index :revision_items, [:user_id, :source_type, :source_id], unique: true
  end
end
