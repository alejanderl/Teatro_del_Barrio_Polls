# encoding: utf-8


def test_sign_in(user)
  user.id = 1
  controller.sign_in(user)
end






def user_login (email, password)

  visit new_user_session_path
  fill_in "user_email"   , :with => email
  fill_in "user_password", :with => password
  
  
  click_button "Entrar" 
	# fakes current user in test scope
  @current_user = User.find_by_email email

end




def create_sample_users

 user_admin ||= User.create(:email => "admin@example.com",
  			  :password => "admin123",
  			  :password_confirmation => "admin123",
          :admin => 1          
  			  )





 
end
