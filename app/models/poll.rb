class Poll < ActiveRecord::Base

	
	serialize :answers

	has_many :questions
	belongs_to :user

	


	
end
