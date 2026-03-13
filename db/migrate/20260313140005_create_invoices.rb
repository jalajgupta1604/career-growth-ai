class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: true, foreign_key: true
      t.string :invoice_number, null: false
      t.integer :amount, null: false
      t.integer :tax_amount, default: 0
      t.integer :total_amount, null: false
      t.string :gstin
      t.string :status, default: "generated"
      t.jsonb :line_items, default: []
      t.jsonb :billing_address, default: {}
      t.datetime :issued_at
      t.datetime :paid_at
      t.timestamps
    end

    add_index :invoices, :invoice_number, unique: true
  end
end
