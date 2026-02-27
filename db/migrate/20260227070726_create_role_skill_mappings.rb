class CreateRoleSkillMappings < ActiveRecord::Migration[8.0]
  def change
    create_table :role_skill_mappings do |t|
      t.string :role
      t.references :skill, null: false, foreign_key: true
      t.float :importance_weight

      t.timestamps
    end
  end
end
