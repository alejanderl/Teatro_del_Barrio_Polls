class Taxonomy < Term

  #Taxonomies are terms with parent_id == 0
  default_scope {where(:parent_id => 0)}
  has_many :terms



  def get_linage




  end


end