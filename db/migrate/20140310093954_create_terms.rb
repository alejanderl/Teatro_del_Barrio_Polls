class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|

      t.integer :parent_id, default:0, :null => false
      t.string  :name
      t.string  :type
      t.timestamps
    end
  end
end
