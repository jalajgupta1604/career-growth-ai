class CreateNegotiationSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :negotiation_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :current_offer, precision: 12, scale: 2
      t.decimal :expected_salary, precision: 12, scale: 2
      t.string :company_name
      t.string :offer_role
      t.jsonb :benefits_data, default: {}
      t.jsonb :strategy_data, default: {}
      t.jsonb :talking_points, default: []
      t.jsonb :counter_offer_data, default: {}
      t.float :negotiation_score
      t.timestamps
    end

    add_index :negotiation_sessions, [:user_id, :created_at]
  end
end
