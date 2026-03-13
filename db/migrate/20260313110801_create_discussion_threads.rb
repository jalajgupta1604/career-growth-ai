class CreateDiscussionThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :discussion_threads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :category, null: false
      t.boolean :pinned, default: false, null: false
      t.integer :replies_count, default: 0, null: false

      t.timestamps
    end
  end
end
