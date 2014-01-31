describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  
  it "logged user create a poll " ,:focus, :js do


  	user_login "admin@example.com", "admin123"


  	
  	click_link "Votaciones"

  	click_link "Nuevo"

  	

  	sleep 1



  end



end