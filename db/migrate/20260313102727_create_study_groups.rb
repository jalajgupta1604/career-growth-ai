class CreateStudyGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :study_groups do |t|
      t.string :name, null: false
      t.text :description
      t.string :target_company
      t.string :target_role
      t.integer :max_members, default: 10
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
