class CreateCareerSimulations < ActiveRecord::Migration[8.0]
  def change
    create_table :career_simulations do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :scenario_data, default: {}, null: false
      t.jsonb :result_data, default: {}, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :career_simulations, [:user_id, :created_at]
  end
end
