class CreateSalaryForecasts < ActiveRecord::Migration[8.0]
  def change
    create_table :salary_forecasts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :current_salary, null: false
      t.jsonb :projected_salaries, default: {}, null: false
      t.jsonb :skill_plan, default: {}, null: false
      t.jsonb :market_factors, default: {}, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
