#encoding: utf-8
require 'spec_helper'

describe "Membserships testing"   do
  
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

	it " user register and membership already exists "  do

	membership = create_membership

	user = create_user :email => membership.email
	user_login membership.email, user.password
	create_poll
	visit poll_path Poll.last, locale: :es 
	page.should have_content "Mi voto" 



	end

	it "load a CSV"  do
		csv_array = []
		100.times do |number|
			csv_array << "email_correcto#{number}@correcto.eu" 
		end
	
		Dir.mkdir("#{Rails.root}/tmp/test") unless File.directory? "#{Rails.root}/tmp/test"
		File.delete "#{Rails.root}/tmp/test/test_csv.csv" if File.exist? "#{Rails.root}/tmp/test/test_csv.csv"
		

		file =  File.open("#{Rails.root}/tmp/test/test_csv.csv","w")

		file.puts csv_array.join ","
		file.close


        user_login "admin@example.com", "admin123"
        visit memberships_path


        click_link "Añadido masivo"
        
        id_input_file =  find("input[type='file']")['id']

        attach_file(id_input_file,"#{Rails.root}/tmp/test/test_csv.csv")
        

        click_button "enviar archivo"


        page.should have_content "email_correcto1@correcto.eu"
        

        File.delete "#{Rails.root}/tmp/test/test_csv.csv"

	end

end