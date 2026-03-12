class CreateChallengeAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :challenge_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_challenge, null: false, foreign_key: true
      t.jsonb :answer_data, default: {}
      t.integer :score, default: 0
      t.datetime :completed_at

      t.timestamps
    end

    add_index :challenge_attempts, [:user_id, :daily_challenge_id], unique: true
  end
end
