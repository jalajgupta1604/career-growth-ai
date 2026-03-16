class AddEmployerBillingAndCandidateReveals < ActiveRecord::Migration[8.0]
  def change
    create_table :candidate_reveals do |t|
      t.references :employer_profile, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :candidate_reveals, [:employer_profile_id, :user_id], unique: true

    change_table :employer_profiles do |t|
      t.string :slug
      t.string :company_website
      t.string :headquarters
      t.integer :candidate_reveal_credits, default: 0
      t.string :billing_plan
      t.datetime :billing_period_end
    end

    add_index :employer_profiles, :slug, unique: true
  end
end
