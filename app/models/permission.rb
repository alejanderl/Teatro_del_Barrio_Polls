class Permission < Struct.new(:user)
  

  def allow?(controller, action)

        
      
        
        return true if controller == "devise\/confirmations"
        return true if controller == "devise\/registrations"   
        return true if controller == "devise\/sessions"
        return true if controller == "devise\/passwords" 
        return true if controller == "landing" 
        return true if controller == "home"
        return true if controller == "polls"&&( %[show index].include? action)
        
        
    if user.member?
      return true if %[votes].include? controller
    end


    if user.admin?
      return true
    end
    
    false
  
  end
end