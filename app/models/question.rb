class Question < ActiveRecord::Base


	belongs_to :poll
	before_create {|_this| _this.answers ||= {}}
	serialize :answers
end
