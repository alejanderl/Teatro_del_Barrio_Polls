class Question < ActiveRecord::Base


	belongs_to :poll
	before_create {|_this| _this.answers ||= {}}
	serialize :answers


	validates :matter , :presence => true

	



	def vote! user, params

		return false unless user
		
		the_vote = (params == "yes") ? 1 : 0

		self.answers[user.id.to_s] = the_vote
		self.save

	end

	def voted? user

		return true if self.answers.has_key?(user.id.to_s)
		false

	end
	
	class << self
		def vote params

			params.each do |voting_options|

				define_method("count_#{voting_options}") do 

					debugger
					sleep 1


				end


			end

		end
	end	

	vote [:yes, :no]




	
end
