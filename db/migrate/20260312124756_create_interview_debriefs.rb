class CreateInterviewDebriefs < ActiveRecord::Migration[8.0]
  def change
    create_table :interview_debriefs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :role_applied
      t.date :interview_date
      t.jsonb :questions_data, default: []
      t.text :user_notes
      t.jsonb :ai_analysis, default: {}
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :interview_debriefs, [:user_id, :created_at]
  end
end
