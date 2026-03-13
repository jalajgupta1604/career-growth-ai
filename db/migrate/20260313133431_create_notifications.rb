class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :category
      t.datetime :read_at
      t.string :action_url

      t.timestamps
    end
  end
end
