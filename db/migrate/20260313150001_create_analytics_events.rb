class CreateAnalyticsEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :analytics_events do |t|
      t.references :user, null: true, foreign_key: true
      t.string :event_type, null: false
      t.string :resource_type
      t.integer :resource_id
      t.jsonb :properties, default: {}
      t.string :session_id
      t.string :ip_address
      t.string :user_agent
      t.timestamps
    end
    add_index :analytics_events, :event_type
    add_index :analytics_events, :created_at
    add_index :analytics_events, [:resource_type, :resource_id]
  end
end
