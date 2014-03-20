class Poll < ActiveRecord::Base

	


	has_many   :questions, -> { order('id DESC') } , :dependent => :destroy 

	belongs_to :user

	has_many :taxonomizables, :as => :item, :dependent => :destroy
  	has_many :terms, :through => :taxonomizables  

	validates :user_id,
			  :start_date,
			  :end_date,
			  :title,
			  :presence => :true

	validate :is_editable?

	validate :right_date

	after_initialize {|_this| @now = Time.now}
	accepts_nested_attributes_for :questions, :allow_destroy => true

	VOTING_ACCESS = %w[public guest member]



	# Each poll has at least one question. Question matter must be present.
	before_validation {|_this| _this.questions.first || _this.questions.build  }



	def is_votable?
		self.state == 1
	end



	def state

		return 2 if self.start_date  > @now # programmed
		return 1 if (self.start_date < @now && self.end_date > @now) # open
		return 0 if (self.end_date   < @now) # close

	end

	def status

		case self.state
		when 2 
			"programmed"
		when 1
			"open"
		when 0
			"close"
			
		end

	end

	def is_editable?

		#not editable if there's already answers
		self.questions.each do |question|
			return false if question.answers.count > 0
		end
		self.state != 0 if self.start_date&&self.end_date
	end

	def right_date
		if self.end_date&&self.start_date
			self.errors.add(:end_date, :greater_than, :count => "activerecord.attributes.poll.start_date".t )  if self.end_date < self.start_date 
			self.errors.add(:end_date, :must_be_in_the_future )   if self.end_date < (Time.now + 1.day ) 
		end
	end


  def vote_access=(roles)
    self. voting_access_mask = (roles & VOTING_ACCESS).map { |r| 2**VOTING_ACCESS.index(r) }.sum
  end
  
  def vote_access
    VOTING_ACCESS.reject { |r| ((voting_access_mask || 0) & 2**VOTING_ACCESS.index(r)).zero? }
  end


  def can_vote?( user = User.new )
  		
  		return true if     self.vote_access.include?                      "public"
  		return true if     user.email?   && (self.vote_access.include?    "guest")
  		return true if     user.member?  && (self.vote_access.includes?   "member")
  		#TODO Admins can vote or should they be members aswell?
  		return true if     user.admin?
  		false
  end



	
end
