module TaxonomiesHelper
  
  def button_create_term(key, value , term)
    
    render(:partial => 'taxonomies/create_term_button', :locals =>{:key => key, :value => value, :term => term})
    
  end
  
  def check_sons(id)
    
    @terms.select {|x| x[:parent_id]==id}.length >0
  end
  
# Form field for taxonomies   
  def terms_field_for(taxonomy, object)
    
    taxonomy_terms = OrderedArray.new(Term.get_taxonomy_terms  taxonomy).order
    render "taxonomies/family_names/family_names", {:taxonomy_terms => taxonomy_terms,:taxonomy_name => taxonomy, :object => object}
    
  end
  
  def print_terms_for(object,*taxonomies)
    final_render ||= ""
    taxonomies.each do |taxonomy_arg|
      terms = object.terms.where(:taxonomy_name => taxonomy_arg)
      final_render += render("taxonomies/family_names/print_terms_for", {:terms => terms,:taxonomy => taxonomy_arg}) if terms.length > 0
    end
    final_render.html_safe
  end
  
  def terms_list(object)
    render "taxonomies/terms_list", :var => object
    
  end

end
