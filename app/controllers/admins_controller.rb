class AdminsController < ApplicationController


	def index

		@admins = User.where(admin: true).page params[:page]
		@admin = User.new

	end

	def create

		@user = User.find_by_email params[:user][:email] 


		if @user
			@user.update_attributes admin:true
			redirect_to admins_path, :notice => "User_added_as_admin", user_email:@user.email
		else
			redirect_to admins_path, :error =>   "can't update the user"
		end



	end

	def change_superadmin

		@user = User.find params[:user_id] 


		if @user
			User.set_superadmin current_user, @user
			redirect_to admins_path, :notice => "admins.superadmin_changed", user_email:@user.email
		else
			redirect_to admins_path, :error =>   "can't update the user"
		end

	end

	def destroy

		@user = User.find params[:id] 


		if @user
			@user.update_attributes admin:false
			redirect_to admins_path, :notice => "User_deleted_as_admin", user_email:@user.email
		else
			redirect_to admins_path, :error =>   "can't find the user", user_email:""
		end

	end



end