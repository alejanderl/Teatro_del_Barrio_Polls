class Taxonomy < Term

	default_scope {where(:parent_id => 0)}

end