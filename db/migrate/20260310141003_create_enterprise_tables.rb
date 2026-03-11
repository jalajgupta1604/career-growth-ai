class CreateEnterpriseTables < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :domain
      t.string :industry
      t.string :size_range
      t.string :city
      t.string :plan_type, default: "basic"
      t.integer :max_seats, default: 10
      t.jsonb :settings, default: {}
      t.boolean :active, default: true
      t.timestamps
    end

    add_index :companies, :domain, unique: true
    add_index :companies, :active

    create_table :company_members do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, default: "member"
      t.datetime :invited_at
      t.datetime :joined_at
      t.timestamps
    end

    add_index :company_members, [:company_id, :user_id], unique: true
    add_index :company_members, :role

    create_table :company_analytics_snapshots do |t|
      t.references :company, null: false, foreign_key: true
      t.string :period, null: false
      t.jsonb :salary_data, default: {}
      t.jsonb :skill_data, default: {}
      t.jsonb :hiring_data, default: {}
      t.jsonb :benchmark_data, default: {}
      t.jsonb :attrition_data, default: {}
      t.integer :team_size
      t.float :avg_salary
      t.float :avg_experience
      t.timestamps
    end

    add_index :company_analytics_snapshots, [:company_id, :period], unique: true, name: "idx_company_analytics_period"
  end
end
