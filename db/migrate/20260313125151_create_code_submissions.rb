class CreateCodeSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :code_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :language, default: "python", null: false
      t.text :code, null: false
      t.jsonb :problem_data, default: {}, null: false
      t.jsonb :test_results, default: {}, null: false
      t.jsonb :ai_feedback, default: {}, null: false
      t.integer :score, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
