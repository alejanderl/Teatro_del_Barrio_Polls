class Membership < ActiveRecord::Base

	belongs_to :user, :foreign_key => :email,
					  :primary_key => :email


	validates :email , presence:true, uniqueness: true












end
