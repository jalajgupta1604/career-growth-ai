class AddAdminRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :admin_role, :string, default: "none", null: false
  end
end
