class CreateEmployerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :employer_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name, null: false
      t.string :company_domain
      t.string :company_size
      t.string :industry
      t.string :company_logo_url
      t.text :company_description
      t.boolean :verified, default: false
      t.string :verification_token
      t.datetime :verified_at

      t.timestamps
    end

    add_index :employer_profiles, :company_domain
    add_index :employer_profiles, :verification_token, unique: true
  end
end
