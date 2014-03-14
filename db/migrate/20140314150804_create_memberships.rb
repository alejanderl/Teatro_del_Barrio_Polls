class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :email
      t.boolean :active, default:true, :null => false
      t.string :membership_code

      t.timestamps
    end
  end
end
