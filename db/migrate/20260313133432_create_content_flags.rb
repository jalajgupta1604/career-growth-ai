class CreateContentFlags < ActiveRecord::Migration[8.0]
  def change
    create_table :content_flags do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flaggable, polymorphic: true, null: false
      t.string :reason
      t.integer :status
      t.text :notes
      t.references :resolved_by, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
