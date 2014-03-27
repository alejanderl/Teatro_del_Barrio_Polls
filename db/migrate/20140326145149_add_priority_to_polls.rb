class AddPriorityToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :priority, :boolean, :default => false
  end
end
