module PollsHelper

	def status_badge poll
	
		case poll.state

		when 0
			css_class = "warning"
			status    = "close"
		when 1 
			css_class = "success"
			status    = "open"
		when 2
			css_class = "info"
			status    = "programmed"
		end

		render "polls/status_badge", :css_class => css_class, :status => status


	end

	def status_class poll
	
		case poll.state

		when 0
			css_class = "warning"
			status    = "close"
		when 1 
			css_class = "success"
			status    = "open"
		when 2
			css_class = "info"
			status    = "programmed"
		end

		css_class


	end

end

