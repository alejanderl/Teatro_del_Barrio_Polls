class Term < ActiveRecord::Base

	  attr_accessor :depth

	  has_many :taxonomizables
  	  has_many :items, :through => :taxonomizables, :source_type => :item


  	  belongs_to :taxonomy
  	  belongs_to :parent ,:class_name => "Term",
                          :foreign_key => :parent_id  

      before_save :check_taxonomy



  	def self.taxonomies 
  		Term.where(:parent_id => 0)
	end
	def taxonomy_name
		self.taxonomy.name
	end

	def depth
		
		@depth ||= 0
	end

	private

	def check_taxonomy
		self.taxonomy_id = parent.taxonomy_id if self.parent_id&&!taxonomy_id 
		self.parent_id   = taxonomy_id        if taxonomy_id&&!self.parent_id
	end

end
