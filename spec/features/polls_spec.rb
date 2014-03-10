#encoding: utf-8
require 'spec_helper'

describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  
  it "logged user create a poll " , :js do


  	user_login "admin@example.com", "admin123"


  	click_link "Votaciones"

  	click_link "Nuevo"
    
    fill_in "poll_title", :with => "Título de la votación"
    fill_in "poll_description", :with => "Descripción de la votación"
    fill_in "poll_start_date", :with => Time.now
    fill_in "poll_end_date", :with => Time.now + 1.month
    
    4.times do 
      click_link "add_question"
    end

    within "#questions" do
      
      all(:xpath ,".//input[@type='text']").each_with_index do |element, index|

        element.set "Pregunta #{index.to_i + 1}"
      end

    end

    click_button "Guardar"
    page.should have_content "Título de la votación"
    page.should have_content "Pregunta 5"

  end


  it "Members can´t create polls", :js do
    
    user_login "member@example.com", "member123"
    visit root_path(:locale => :es)
    have_selector(:link_or_button, 'Votaciones')
    click_link "Votaciones"
    page.should_not have_selector(:link_or_button, 'Nuevo')
    
      
    end

  it "Members can vote"  do
    create_poll
    user_login "member@example.com", "member123"
    
    visit poll_path(Poll.last.id, :locale => :es)
    #vote yes
    first(".btn-success").click
    page.should have_content "Has votado si"
    within ".vote-results" do
      within ".list-group-item-success" do
        page.should have_content "1"
      end

    end
    click_link "Cambiar mi voto"

    page.should_not have_content "Has votado si"
    within ".vote-results" do
      within ".list-group-item-success" do
        page.should have_content "0"
      end
    end
    first(".btn-warning").click

    page.should have_content "Has votado no"
    within ".vote-results" do
      within ".list-group-item-warning" do
        page.should have_content "1"
      end
    end
  end

  it "users can not vote experired polls"   do

    create_poll :start_date => (Time.now - 7.days), :end_date => (Time.now - 1.day)
    user_login "member@example.com", "member123"
    
    visit poll_path(Poll.last.id, :locale => :es)
    page.should have_content("Cerrada")
    page.should have_content("No has votado")



  end

end