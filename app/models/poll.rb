class Poll < ActiveRecord::Base

	


	has_many   :questions, :dependent => :destroy

	belongs_to :user

	accepts_nested_attributes_for :questions, :allow_destroy => true


	validates :user_id , :presence => :true


	# Each poll has at least one question
	before_validation {|_this| _this.questions.first || _this.questions.build  }






	
end
