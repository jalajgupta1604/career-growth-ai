class CreateReferrals < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :referral_code, :string
    add_column :users, :referred_by_id, :bigint
    add_index :users, :referral_code, unique: true
    add_index :users, :referred_by_id

    create_table :referral_rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :referred_user, null: false, foreign_key: { to_table: :users }
      t.string :reward_type, null: false
      t.integer :reward_days, default: 0
      t.string :status, default: "pending"
      t.datetime :credited_at
      t.timestamps
    end

    add_index :referral_rewards, [:user_id, :referred_user_id], unique: true, name: "idx_referral_rewards_unique"
    add_index :referral_rewards, :status
  end
end
