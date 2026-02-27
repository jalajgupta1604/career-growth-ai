class CreateResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :resumes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_url
      t.jsonb :parsed_data
      t.integer :parsing_status, default: 0

      t.timestamps
    end
  end
end
