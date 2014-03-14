class Membership < ActiveRecord::Base

	belongs_to :user, :foreign_key => :email,
					  :primary_key => :email

	after_update :link_user










end
