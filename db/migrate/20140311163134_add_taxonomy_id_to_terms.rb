class AddTaxonomyIdToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :taxonomy_id, :integer
  end
end
