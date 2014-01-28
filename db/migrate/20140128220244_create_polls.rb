class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.text :description
      t.text :answers
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
