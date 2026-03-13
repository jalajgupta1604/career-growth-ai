class CreateCompanyReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :company_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.integer :overall_rating, null: false
      t.text :pros
      t.text :cons
      t.string :interview_difficulty
      t.string :salary_range
      t.string :role_reviewed
      t.string :employment_status, default: "current"
      t.boolean :verified, default: false

      t.timestamps
    end

    add_index :company_reviews, :company_name
  end
end
