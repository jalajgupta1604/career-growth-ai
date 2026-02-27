class CreateSalaryBenchmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :salary_benchmarks do |t|
      t.string :role
      t.string :city
      t.string :experience_range
      t.decimal :min_salary
      t.decimal :median_salary
      t.decimal :max_salary
      t.string :company_type

      t.timestamps
    end
  end
end
