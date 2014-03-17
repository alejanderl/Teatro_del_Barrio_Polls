#encoding: utf-8
require 'spec_helper'

describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
	it "add new membership and user already exist"  do

		user = create_user
		user_login "admin@example.com", "admin123"
		visit memberships_path locale: :es
		click_link "show-membership-form"
		fill_in "membership_email", with: user.email
		click_button "crear"
		within "#member_#{user.membership.id}" do

			page.should_not have_content "no"
			page.should have_content "si"

		end
	end

	it " user register and membership already exists " do

	membership = create_membership

	create_user :email => membership.email


	end


end