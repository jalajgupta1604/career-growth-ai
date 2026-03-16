class AddDunningAndPlanChangeToSubscriptions < ActiveRecord::Migration[8.0]
  def change
    change_table :subscriptions do |t|
      t.integer :dunning_attempts, default: 0
      t.datetime :last_dunning_at
      t.string :dunning_state # nil, reminded, urgent, paused
      t.string :previous_plan_name
      t.datetime :plan_change_scheduled_at
      t.string :pending_plan_name
    end

    change_table :payments do |t|
      t.string :razorpay_refund_id
      t.datetime :refunded_at
      t.text :refund_reason
      t.references :refunded_by, null: true, foreign_key: { to_table: :users }
    end

    add_index :subscriptions, :dunning_state
  end
end
