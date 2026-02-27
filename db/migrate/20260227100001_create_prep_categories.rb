class CreatePrepCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :prep_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :icon_name
      t.string :color_class
      t.integer :position, default: 0
      t.string :difficulty_level
      t.integer :estimated_hours

      t.timestamps
    end

    add_index :prep_categories, :slug, unique: true
    add_index :prep_categories, :position
  end
end
