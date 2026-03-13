class CreatePeerPracticeSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :peer_practice_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :partner, foreign_key: { to_table: :users }
      t.string :session_type, default: "mock_interview", null: false
      t.integer :status, default: 0, null: false
      t.string :target_company
      t.string :target_role
      t.datetime :scheduled_at
      t.jsonb :feedback_data, default: {}
      t.text :notes

      t.timestamps
    end
  end
end
