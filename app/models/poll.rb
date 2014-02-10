class Poll < ActiveRecord::Base

	


	has_many   :questions, :dependent => :destroy,  :order => 'id DESC'

	belongs_to :user

	accepts_nested_attributes_for :questions, :allow_destroy => true


	validates :user_id, :start_date, :end_date, :title, :presence => :true


	# Each poll has at least one question. Question matter must be present.
	before_validation {|_this| _this.questions.first || _this.questions.build  }

	def is_open?
		now = Time.now
		
		self.start_date < now && self.end_date > now
	end






	
end
