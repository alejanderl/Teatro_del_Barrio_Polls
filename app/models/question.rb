class Question < ActiveRecord::Base


	belongs_to :poll
	after_initialize {|_this| _this.answers ||= {}}
	serialize :answers


	validates :matter , :presence => true



	def vote! user, params

		if self.poll.is_open?

			return false unless user
			
			the_vote = (params == "yes") ? 1 : 0
			
			self.answers[user.id] = the_vote
			
			self.save
		else
			return false
		end

	end

	# singleton methods for answers
	def answers
		
		answers = super 

		def answers.count_yeses
			self.yeses.count			
		end

		def answers.count_noes
			self.noes.count
		end

		def answers.yeses
			@yeses ||= self.select { |key, value| value == 1 }
		end

		def answers.noes
			@noes ||= self.select { |key, value| value == 0 }
		end 


		answers

	end



	
end
