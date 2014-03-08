class Permission < Struct.new(:user)
  

  def allow?(controller, action)
      
        return true if controller == "devise\/registrations"   
        return true if controller == "devise\/sessions"
        return true if controller == "devise\/passwords" 
        return true if controller == "landing" 
        return true if controller == "home"
      
    if controller == "polls"
       return true if user.admin?
       return true if action.in?(%w[index show])
      
    end


    if controller == "votes"
      return true
    end

           
        
       false
  end
end