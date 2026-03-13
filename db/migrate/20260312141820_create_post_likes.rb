class CreatePostLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :post_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community_post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_likes, [:user_id, :community_post_id], unique: true
  end
end
