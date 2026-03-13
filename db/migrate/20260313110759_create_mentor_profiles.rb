class CreateMentorProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :expertise, default: [], null: false
      t.boolean :available, default: true, null: false
      t.text :bio
      t.integer :max_mentees, default: 3, null: false

      t.timestamps
    end
  end
end
