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
	def destroy_vote! user
		

		self.answers.delete user.id

		self.save

	end



	def voted? user
		
		
		return true if self.answers.has_key?(user.id)
		false

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

			def answers.my_vote user

				self[user.id] == 1 ? "yes" : "no"


			end


			answers

		end



	
end
