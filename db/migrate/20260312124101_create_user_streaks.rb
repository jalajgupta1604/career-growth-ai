class CreateUserStreaks < ActiveRecord::Migration[8.0]
  def change
    create_table :user_streaks do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.integer :current_streak, default: 0, null: false
      t.integer :longest_streak, default: 0, null: false
      t.date :last_completed_date

      t.timestamps
    end
  end
end
