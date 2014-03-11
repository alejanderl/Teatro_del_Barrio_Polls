class Taxonomy < Term

	#Taxonomies are terms with parent_id == 0
	default_scope {where(:parent_id => 0)}


	def terms
		Terms.where(:parent_id => self.id)
	end

	def get_linage




	end


end