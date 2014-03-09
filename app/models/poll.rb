class Poll < ActiveRecord::Base

	


	has_many   :questions, :dependent => :destroy,  :order => 'id DESC'

	belongs_to :user

	accepts_nested_attributes_for :questions, :allow_destroy => true


	validates :user_id, :start_date, :end_date, :title, :presence => :true

	validate :is_editable?


	# Each poll has at least one question. Question matter must be present.
	#before_validation {|_this| _this.questions.first || _this.questions.build  }

	def is_open?
		now = Time.now
		
		self.start_date < now && self.end_date > now
	end

	def is_editable?
		#not editable if there's already answers
		self.questions.each do |question|
			return false if question.answers.count > 0
		end
	end





	
end
