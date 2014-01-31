require 'spec_helper'


describe "Set" do

    it "works! (now write some real specs)", :focus do
    	
    	
    	
    	visit root_path
    	visit "/en"
		assert (I18n.locale == :en)

    	visit "/es"
    	assert (I18n.locale == :es)
    	
  end
end
