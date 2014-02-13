require 'spec_helper'



describe "Set" do

    before :each do

        create_sample_users
    end

    it "Get right locale" do
    	
    	
    	
    	visit root_path(:locale => :en)
    	
		assert (I18n.locale == :en)
        visit root_path(:locale => :es)
    	
    	assert (I18n.locale == :es)
    	
    end
   


    it "Auth/Unauth to each home", :js do

        visit root_path(:locale => :es)
        page.should have_content "Bienvenido al sistema de votacion de Teatro del Barrioor"
        
        user_login "member@example.com", "member123"
        visit root_path(:locale => :es)
        page.should have_content('Votacion')

    end

    

end
