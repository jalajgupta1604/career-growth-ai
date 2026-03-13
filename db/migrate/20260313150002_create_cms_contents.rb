class CreateCmsContents < ActiveRecord::Migration[8.0]
  def change
    create_table :cms_contents do |t|
      t.string :content_type, null: false  # lesson, company_pack, challenge, skill_trend
      t.string :title, null: false
      t.string :slug
      t.text :body
      t.jsonb :metadata, default: {}
      t.string :status, default: "draft"  # draft, published, archived
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.datetime :published_at
      t.integer :position, default: 0
      t.timestamps
    end
    add_index :cms_contents, :slug, unique: true
    add_index :cms_contents, [:content_type, :status]
  end
end
