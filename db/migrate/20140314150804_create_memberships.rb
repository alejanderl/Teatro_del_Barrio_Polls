class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.string :email
      t.boolean :active, default:1, :null => false
      t.string :membership_code

      t.timestamps
    end
  end
end
