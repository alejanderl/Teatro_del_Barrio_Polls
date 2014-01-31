class Role < ActiveRecord::Base
	has_many :memberships
	has_many :users, :through => :memberships

	validates_uniqueness_of :name
	
end
