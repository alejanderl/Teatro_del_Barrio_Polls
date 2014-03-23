#encoding: utf-8
require 'spec_helper'

describe "Voting access testing"   do
  
  before :each do
    create_sample_users
    

  end
  
	it "not logged users, logged and members can vote in public polls"  do

		poll = create_poll vote_access: ["public"]
		visit poll_path(poll,locale: :es)
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
    	within ".vote-results" do
      		within ".votes-yes" do
      	  page.should have_content "1"
     	 end

   		 end
   		user_login "guest@example.com", "guest123"
   		visit poll_path(poll,locale: :es)
		
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
		page.should have_content "Has votado si"
    	within ".vote-results" do
    		within ".votes-yes" do
      		  page.should have_content "2"
     		 end

   		 end

   		user_logout
   		user_login "member@example.com", "member123"
   		visit poll_path(poll,locale: :es)
		
		find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
		page.should have_content "Has votado si"
    	within ".vote-results" do
    		within ".votes-yes" do
      		  page.should have_content "3"
     		 end

   		 end


	end
	it " logged users and members can vote in guest polls"  do
		poll = create_poll vote_access: ["guest"]

		user_login "guest@example.com", "guest123"
   		visit poll_path(poll,locale: :es)

		
		
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
    page.should have_content "Has votado si"
      within ".vote-results" do
        within ".votes-yes" do
      		  page.should have_content "1"
     		 end

   		 end

   		user_logout
   		user_login "member@example.com", "member123"
   		visit poll_path(poll,locale: :es)
		
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
    page.should have_content "Has votado si"
      within ".vote-results" do
        within ".votes-yes" do
      		  page.should have_content "2"
     		 end

   		 end

	end

	it "members can vote in members polls"  do

		poll = create_poll 
		user_login "member@example.com", "member123"
   		visit poll_path(poll,locale: :es)
		page.should have_xpath("//a[contains(@href,'/vote/')]")
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
    page.should have_content "Has votado si"
      within ".vote-results" do
        within ".votes-yes" do
      		  page.should have_content "1"
     		 end

   		 end

	end
	it "not logged users can't vote in guest or members polls"   do


		poll_member = create_poll 
		
   	visit poll_path(poll_member,locale: :es)
		
    page.should_not have_xpath("//a[contains(@href,'/vote/')]")
		visit voting_path(poll_member.questions.first, "yes", locale: :es )
		
		visit poll_path(poll_member,locale: :es)

    	within ".vote-results" do
    		within ".votes-yes" do
      		  page.should have_content "0"
     		 end

   		 end

   		poll_guest = create_poll :vote_access => ["guest"]
   		visit poll_path(poll_guest,locale: :es)
		
		page.should_not have_xpath("//a[contains(@href,'/vote/')]")
		visit voting_path(poll_guest.questions.first, "yes", locale: :es )
		
		visit poll_path(poll_guest,locale: :es)

    	within ".vote-results" do
    		within ".votes-yes" do
      		  page.should have_content "0"
     		end
     	end


	end

	it "guest user can't vote in members polls"   do

		poll_member = create_poll 
		user_login "guest@example.com", "guest123"		
   		visit poll_path(poll_member,locale: :es)
   		
   		
		page.should_not have_xpath("//a[contains(@href,'/vote/')]")
		visit voting_path(poll_member.questions.first, "yes", locale: :es )
		
		visit poll_path(poll_member,locale: :es)

    	within ".vote-results" do
    		within ".votes-yes" do
      		  page.should have_content "0"
     		 end

   		 end




	end
end