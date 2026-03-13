class CreateApiKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :api_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key, null: false
      t.string :name, null: false
      t.integer :calls_count, default: 0, null: false
      t.integer :rate_limit, default: 100, null: false
      t.string :tier, default: "free", null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :api_keys, :key, unique: true
  end
end
