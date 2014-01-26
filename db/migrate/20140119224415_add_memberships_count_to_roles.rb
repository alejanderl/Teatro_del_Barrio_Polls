class AddMembershipsCountToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :memberships_count, :integer
  end
end
