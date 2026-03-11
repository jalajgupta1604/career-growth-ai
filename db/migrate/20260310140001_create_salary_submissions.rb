class CreateSalarySubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :salary_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false
      t.string :city, null: false
      t.integer :experience_years, null: false
      t.decimal :base_salary, precision: 12, scale: 2, null: false
      t.decimal :total_ctc, precision: 12, scale: 2
      t.string :company_name
      t.string :company_type
      t.jsonb :components_data, default: {}
      t.boolean :verified, default: false
      t.boolean :anonymous, default: true
      t.timestamps
    end

    add_index :salary_submissions, [:role, :city, :experience_years], name: "idx_salary_submissions_lookup"
    add_index :salary_submissions, :verified
    add_index :salary_submissions, :created_at
  end
end
