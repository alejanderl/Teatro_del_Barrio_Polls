#encoding: utf-8
require 'spec_helper'

describe "Taxonomies testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  it "create new terms in the main taxonomy"  , :js do

	  	user_login "admin@example.com", "admin123"

	  	visit taxonomies_path(:locale => :es)
	  	
	  	within "#taxonomy_1" do

	  		first(".panel-body a.create-term").click
	  		fill_in "term_name" , :with => "termino 1"

	  		click_button "Añadir término"

	  	end
	  	 page.should have_content "termino 1"
  end

    pending "edit terms in the main taxonomy"  , :js do

	  	user_login "admin@example.com", "admin123"
	  	Term.where("taxonomy_id > 0").destroy_all
	  	5.times do 
	  		create_term
	  	end
	  	visit taxonomies_path(:locale => :es)

	  	
  end




end