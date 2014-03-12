module PollsHelper

	def status_badge poll
	
		case poll.state

		when 0
			css_class = "warning"
			status    = "close"
		when 1 
			css_class = "succes"
			status    = "open"
		when 2
			css_class = "info"
			status    = "programmed"
		end

		render "polls/status_badge", :css_class => css_class, :status => status


	end

end

