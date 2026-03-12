class CreateCompanyPacks < ActiveRecord::Migration[8.0]
  def change
    create_table :company_packs do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :logo_icon
      t.string :difficulty_level, default: "medium"
      t.jsonb :interview_rounds, default: []
      t.jsonb :tips_data, default: []
      t.jsonb :questions_data, default: []
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :company_packs, :slug, unique: true
  end
end
