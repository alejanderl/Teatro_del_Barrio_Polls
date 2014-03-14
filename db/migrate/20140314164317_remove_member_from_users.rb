class RemoveMemberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :member, :boolean
  end
end
