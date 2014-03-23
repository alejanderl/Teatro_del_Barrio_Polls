
class Question < ActiveRecord::Base


	belongs_to :poll

	serialize :answers_public
	serialize :answers_guest
	serialize :answers_member


	validates :matter , :presence => true

	

	after_initialize -> {setup_answers }




	def vote! user, params

		if self.poll.can_vote? user

			the_vote = (params == "yes") ? 1 : 0

			if user
				answers = user.member? ? self.answers_member : self.answers_guest				
				answers[user.id] = the_vote
			else
				# check if public user has already voted
				
				answers_public[params.to_sym] += 1
			end

			self.save

		else
			errors[:poll] << "activerecord.errors.messages.the_poll_is_closed".t
			return false
		end

	end
	def destroy_vote! user
		
		if self.poll.open?
			self.answers_member.delete user.id if user.member?
			self.answers_guest.delete  user.id unless user.member?

			self.save
		else
			errors[:poll] << "activerecord.errors.messages.the_poll_is_closed".t
			return false
		
		end

	end



	def voted? user
		user ||= User.new
		return false unless user.email?
		return true  if (self.answers_guest.merge(self.answers_member)).has_key?(user.id)
		false

	end
	

	# singleton methods for answers
	def answers_count


		self.answers_count_yeses + self.answers_count_noes


	end

	def answers_count_yeses
		self.answers_yeses.count + answers_public[:yes].to_i
	end

	def answers_count_noes

		self.answers_noes.count + answers_public[:no].to_i

	end

	def answers_yeses
		
		answers = answers_guest.merge answers_member
		@yeses ||= answers.select { |key, value| value == 1 }
	end


	def answers_noes
		answers = answers_guest.merge answers_member
		@noes ||= answers.select { |key, value| value == 0 }
	end 

	def answers_my_vote user
		
		if user.email?
			answers = answers_guest.merge answers_member
			answers[user.id] == 1 ? "yes" : "no" if user
		else
			"unknown"
		end
	end


	private

	def setup_answers

		self.answers_member ||= {}
		self.answers_guest  ||= {}
		self.answers_public ||= {yes:0, no:0}

	end



	
end