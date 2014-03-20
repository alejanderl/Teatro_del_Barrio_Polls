class AddAnswersFieldsToQuestions < ActiveRecord::Migration
  def change
    add_column    :questions, :answers_public, :text
    add_column    :questions, :answers_guest, :text
    rename_column :questions, :answers, :answers_member
  end
end
