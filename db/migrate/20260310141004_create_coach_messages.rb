class CreateCoachMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :coach_conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :topic
      t.string :status, default: "active"
      t.jsonb :context_data, default: {}
      t.integer :messages_count, default: 0
      t.timestamps
    end

    add_index :coach_conversations, [:user_id, :created_at]
    add_index :coach_conversations, :status

    create_table :coach_messages do |t|
      t.references :coach_conversation, null: false, foreign_key: true
      t.string :role, null: false
      t.text :content, null: false
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :coach_messages, :created_at
  end
end
