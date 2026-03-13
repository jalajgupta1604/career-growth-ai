class CreateGeneratedResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :generated_resumes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :target_role, null: false
      t.jsonb :resume_data, default: {}, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :generated_resumes, [:user_id, :created_at]
  end
end
