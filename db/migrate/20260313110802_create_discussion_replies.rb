class CreateDiscussionReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :discussion_replies do |t|
      t.references :discussion_thread, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
