class CreateOfferAnalyses < ActiveRecord::Migration[8.0]
  def change
    create_table :offer_analyses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.string :offer_role
      t.decimal :base_salary, precision: 12, scale: 2
      t.decimal :total_ctc, precision: 12, scale: 2
      t.jsonb :components_data, default: {}
      t.jsonb :analysis_data, default: {}
      t.jsonb :red_flags, default: []
      t.jsonb :green_flags, default: []
      t.float :offer_score
      t.string :verdict
      t.timestamps
    end

    add_index :offer_analyses, [:user_id, :created_at]
  end
end
