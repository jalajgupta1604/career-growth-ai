class CreateSkillTrends < ActiveRecord::Migration[8.0]
  def change
    create_table :skill_trends do |t|
      t.string :skill_name, null: false
      t.string :role
      t.string :city
      t.integer :demand_score, default: 0
      t.float :salary_premium_pct, default: 0
      t.string :trend_direction, default: "stable"
      t.integer :job_postings_count, default: 0
      t.jsonb :monthly_data, default: []
      t.string :period, null: false
      t.timestamps
    end

    add_index :skill_trends, [:skill_name, :role, :period], unique: true, name: "idx_skill_trends_unique"
    add_index :skill_trends, :demand_score
    add_index :skill_trends, :trend_direction
  end
end
