class UsersController < ApplicationController

 before_filter do 
    redirect_to new_user_session_path unless current_user && current_user.admin?
  end  

  def index

  	@users=User.all
  end
end
