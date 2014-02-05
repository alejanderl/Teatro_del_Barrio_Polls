#encoding: utf-8
describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  
  it "logged user create a poll " ,:focus, :js do


  	user_login "admin@example.com", "admin123"


  	
  	click_link "Votaciones"

  	click_link "Nuevo"

    fill_in "poll_title", :with => "Título de la votación"
    fill_in "poll_description", :with => "Título de la votación"
    fill_in "poll_start_date", :with => Time.now
    fill_in "poll_end_date", :with => Time.now + 1.month
    4.times do 
      click_link "add_question"
    end

    within "#questions" do
      
      all(:xpath ,".//input[@type='text']").each do |element|
        debugger
        fill_in element, :with => "prueba"
      end
    end
    debugger


  	sleep 1

    sleep 1

  end



end