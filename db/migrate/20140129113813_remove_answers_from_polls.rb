class RemoveAnswersFromPolls < ActiveRecord::Migration
  def change
    remove_column :polls, :answers, :text
  end
end
