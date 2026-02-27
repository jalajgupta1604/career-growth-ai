class CreateCareerReports < ActiveRecord::Migration[8.0]
  def change
    create_table :career_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.float :salary_gap_percentage
      t.jsonb :skill_gap_data
      t.jsonb :roadmap_data
      t.float :interview_score
      t.integer :payment_status, default: 0
      t.string :pdf_url

      t.timestamps
    end
  end
end
