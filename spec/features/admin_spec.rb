#encoding: utf-8
require 'spec_helper'

describe "Admin management testing"   do

  before :each do
    create_sample_users
  end

  it "add new admin"  do

    user_login "superadmin1@example.com", "superadmin123"

    visit admins_path

    click_link "Añadir"

    fill_in "user_email", :with => "guest@example.com"
    click_button "crear"


    page.should have_content( "guest@example.com")



  end


  it "delete admin", :js  do

    user_login "superadmin1@example.com", "superadmin123"

    visit admins_path
    user = User.find_by_email "admin@example.com"

    within "#admin_#{user.id}" do
        first(".glyphicon-remove").click
    end

    page.driver.browser.switch_to.alert.accept

    page.should_not have_content( "admin@example.com")



  end


  it "transfer superadmin", :js   do

      user_login "superadmin1@example.com", "superadmin123"

      visit admins_path
      user = User.find_by_email "admin@example.com"

      within "#admin_#{user.id}" do
        first(".glyphicon-asterisk").click
    end

      page.driver.browser.switch_to.alert.accept

      page.should have_content( "admin@example.com")
      page.should_not have_css( ".glyphicon-asterisk")
      page.should_not have_css( ".glyphicon-remove")
      page.should_not have_content( "Añadir")
      page.should_not have_content( "Acciones")



      user_logout



      user_login "admin@example.com", "admin123"

      visit admins_path

      page.should have_content  "admin@example.com"
      page.should have_content  "superadmin1@example.com"
      page.should have_css      ".glyphicon-asterisk"
      page.should have_css      ".glyphicon-remove"
      page.should have_content  "Añadir"
      page.should have_content  "Acciones"


    end

end