class CreateScheduledChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :scheduled_challenges do |t|
      t.references :cms_content, null: true, foreign_key: true
      t.string :title, null: false
      t.text :question
      t.jsonb :options, default: []
      t.string :correct_answer
      t.text :explanation
      t.string :difficulty, default: "medium"
      t.string :topic
      t.date :scheduled_for
      t.boolean :published, default: false
      t.timestamps
    end
    add_index :scheduled_challenges, :scheduled_for, unique: true
  end
end
