class Membership < ActiveRecord::Base

	belongs_to :user, :foreign_key => :email,
					  :primary_key => :email


	validates :email , presence:true, uniqueness: true, email: true

	# Kaminari DSL
	paginates_per 20




	def self.csv_desctructive



	end

	def parse_csv csv_string 


		if (csv_string =~ /,/) > 0

			updatable_emails = csv_string.gsub!(/(\r\n|\n|\r)/,'').split(",") - Membership.all.pluck(:email)
		


		else


			updatable_emails = csv_string.gsub!(/(\r)/,'').split() - Membership.all.pluck(:email)


		end
		

		updatable_emails.each do |email|
			Membership.create email: email rescue self.errors.add(:massive_update, "#{email} ha fallado")
		end 


		

	end







end
