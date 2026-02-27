class CreatePrepLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :prep_lessons do |t|
      t.references :prep_category, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :topic
      t.integer :duration_minutes
      t.string :difficulty_label
      t.integer :position, default: 0
      t.jsonb :content_data, default: {}
      t.string :thumbnail_url

      t.timestamps
    end

    add_index :prep_lessons, :position
  end
end
