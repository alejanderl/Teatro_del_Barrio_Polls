class AddSuperAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superadmin, :boolean
  end
end
