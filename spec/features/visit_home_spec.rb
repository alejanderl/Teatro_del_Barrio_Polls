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


end
