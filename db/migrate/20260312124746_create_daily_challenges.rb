class CreateDailyChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_challenges do |t|
      t.date :challenge_date, null: false
      t.string :challenge_type, null: false
      t.jsonb :question_data, default: {}, null: false
      t.string :difficulty, default: "medium", null: false

      t.timestamps
    end

    add_index :daily_challenges, :challenge_date, unique: true
  end
end
