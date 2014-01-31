describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  
  it "logged user create a poll " ,:focus  do


  	user_login "admin", "admin123"

  	click_button "Votaciones"

  	click_button "Nuevo"

  	debugger

  	sleep 1


  end



end