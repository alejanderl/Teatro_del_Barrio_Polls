class CreateTaxonomizables < ActiveRecord::Migration
  def change
    create_table :taxonomizables do |t|
      t.integer :item_id
      t.string :item_type
      t.integer :term_id

      t.timestamps
    end
  end
end
