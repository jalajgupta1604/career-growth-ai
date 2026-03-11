class CreateLinkedinProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :linkedin_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :linkedin_uid
      t.string :linkedin_url
      t.string :headline
      t.string :industry
      t.string :location
      t.integer :connections_count
      t.jsonb :positions_data, default: []
      t.jsonb :education_data, default: []
      t.jsonb :skills_data, default: []
      t.jsonb :certifications_data, default: []
      t.jsonb :raw_profile_data, default: {}
      t.string :sync_status, default: "pending"
      t.datetime :last_synced_at
      t.timestamps
    end

    add_index :linkedin_profiles, :linkedin_uid, unique: true
  end
end
