class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string     :razorpay_subscription_id, null: false
      t.string     :razorpay_plan_id, null: false
      t.string     :plan_name, null: false
      t.integer    :status, default: 0, null: false
      t.integer    :amount
      t.string     :short_url
      t.datetime   :current_period_start
      t.datetime   :current_period_end
      t.datetime   :cancelled_at
      t.integer    :total_count
      t.integer    :paid_count, default: 0
      t.string     :razorpay_customer_id
      t.timestamps
    end

    add_index :subscriptions, :razorpay_subscription_id, unique: true
    add_index :subscriptions, :status
  end
end
