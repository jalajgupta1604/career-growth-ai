class CreateWebhookSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :webhook_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url, null: false
      t.string :secret
      t.jsonb :events, default: []  # array of event types to subscribe to
      t.boolean :active, default: true
      t.datetime :last_triggered_at
      t.integer :failure_count, default: 0
      t.timestamps
    end
  end
end
