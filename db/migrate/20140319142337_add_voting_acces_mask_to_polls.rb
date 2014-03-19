class AddVotingAccesMaskToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :voting_access_mask, :integer
  end
end
