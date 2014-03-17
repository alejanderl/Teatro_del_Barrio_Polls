#encoding: utf-8
require 'spec_helper'

describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  

  it "Members can´t create or edit polls" do
    
    user_login "member@example.com", "member123"
    visit root_path(:locale => :es)
    have_selector(:link_or_button, 'Votaciones')
    click_link "Votaciones"

    page.should_not have_selector(:link_or_button, 'Nuevo')
    poll = create_poll
    visit edit_poll_path poll, :locale => :es
    page.should have_content "Not authorized"
    page.should have_css     ".alert-warning"
    
      
    end

    pending "members cannot create memberships" do


  		

 	end
end