class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :role, counter_cache: true

	validates_uniqueness_of :user_id, :scope => :role_id
	
end
