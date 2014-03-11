class Taxonomizable < ActiveRecord::Base

	belongs_to :item , :polymorphic => true
	belongs_to :term
end
