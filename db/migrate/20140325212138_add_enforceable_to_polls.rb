class AddEnforceableToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :enforceable, :boolean,:default => false
  end
end
