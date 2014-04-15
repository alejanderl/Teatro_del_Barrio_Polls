class Poll < ActiveRecord::Base

  belongs_to :user

  has_many   :questions, -> { order('id DESC') } , :dependent => :destroy
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

  after_initialize {|_this| _this.voting_access_mask ||= 4 }


  # Each poll has at least one question. Question matter must be present.
  before_validation {|_this| _this.questions.first || _this.questions.build  }

  paginates_per 10

  VOTING_ACCESS.each do |access_level|
    define_method "#{access_level}?" do
      vote_access.include? access_level
    end
  end

  def state

    return 2 if self.start_date  > @now # programmed
    return 1 if (self.start_date < @now && self.end_date > @now) # open
    return 0 if (self.end_date   < @now) # close

  end

  def open?
    state==1
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
      return false if question.answers_count > 0
    end
    self.state != 0 if self.start_date&&self.end_date
  end

  def right_date
    if self.end_date&&self.start_date
      self.errors.add(:end_date, :greater_than, :count => "activerecord.attributes.poll.start_date".t )  if self.end_date < self.start_date
      self.errors.add(:end_date, :must_be_in_the_future )   if self.end_date < (Time.now  )
    end
  end


  def vote_access=(roles)
    unless roles.nil?
      roles << "guest"  if roles.include? "public"
      roles << "member" if roles.include? "guest"
    end
    self.voting_access_mask = (roles & VOTING_ACCESS).map { |r| 2**VOTING_ACCESS.index(r) }.sum if ((roles&VOTING_ACCESS).count > 0)
  end

  def vote_access
    VOTING_ACCESS.reject { |r| ((voting_access_mask || 0) & 2**VOTING_ACCESS.index(r)).zero? }
  end

  def can_vote?(user)
      return false unless self.published
      return false unless status=="open"
      (user_permissions_translation(user) & vote_access).count > 0
      #user_allowed_to_vote? user
  end

  def allowed_voting? user
    return false unless self.published
    (user_permissions_translation(user) & vote_access).count > 0
  end

  def user_allowed_to_vote?(user)
    if public?
      user.nil?
    elsif member?
      user.member? || user.admin?
    elsif guest?
      user.email?
    end
  end

  def user_permissions_translation(user)
    user_permissions = []
    case
      when user.nil?
        return user_permissions << "public"
      when user.member?||user.admin?
        return user_permissions << "member"
      when user.email?
        return user_permissions << "guest"
    end
  end

  def self.find_polls query = {}
    polls = Poll.all

    polls = polls.where(published: true) if query[:published]
    polls = polls.where(enforceable: true) if query[:enforceable]


    polls = case query[:status]
      when "open"
        polls.where("start_date < ?", Date.today).where("end_date > ?",Date.today)
      when "closed"
        polls.where("end_date < ?",Date.today)
      when "programmed"
        polls.where("start_date > ?",Date.today)
    end if query[:status]

  polls
  end


end
