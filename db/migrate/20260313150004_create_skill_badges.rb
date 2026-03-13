class CreateSkillBadges < ActiveRecord::Migration[8.0]
  def change
    create_table :skill_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.string :badge_type, null: false  # interview_ace, code_master, peer_champion, streak_warrior
      t.string :skill_name
      t.string :level, default: "bronze"  # bronze, silver, gold, platinum
      t.jsonb :criteria_met, default: {}
      t.datetime :earned_at, null: false
      t.timestamps
    end
    add_index :skill_badges, [:user_id, :badge_type, :skill_name], unique: true
  end
end
