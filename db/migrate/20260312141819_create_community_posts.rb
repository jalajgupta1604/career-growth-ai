class CreateCommunityPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :community_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :post_type, null: false, default: "milestone"
      t.string :title
      t.text :content, null: false
      t.boolean :anonymous, default: false
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end

    add_index :community_posts, :created_at
    add_index :community_posts, :post_type
  end
end
