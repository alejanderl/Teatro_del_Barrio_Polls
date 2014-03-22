module ApplicationHelper


 delegate :current_user2, to: :current_user

  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-danger"
        when :alert then "alert alert-warning "
    end
  end




end
