class CreateDepartmentsAndExpandCompanyMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :departments do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.references :head, null: true, foreign_key: { to_table: :users }
      t.references :parent_department, null: true, foreign_key: { to_table: :departments }
      t.text :description
      t.timestamps
    end

    add_index :departments, [:company_id, :name], unique: true

    change_table :company_members do |t|
      t.references :department, null: true, foreign_key: true
      t.string :title
      t.references :manager, null: true, foreign_key: { to_table: :company_members }
      t.string :employment_status, default: "active"
      t.date :start_date
      t.date :end_date
    end

    add_index :company_members, :employment_status
  end
end
