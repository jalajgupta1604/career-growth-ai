class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :category
      t.float :demand_index
      t.float :salary_uplift_index
      t.float :learning_difficulty_index

      t.timestamps
    end
  end
end
