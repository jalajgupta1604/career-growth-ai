class AddDataExportFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :data_export_requested_at, :datetime
    add_column :users, :data_exported_at, :datetime
    add_column :users, :deletion_requested_at, :datetime
    add_column :users, :deletion_scheduled_at, :datetime
  end
end
