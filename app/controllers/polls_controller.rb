class PollsController < ApplicationController

	def index

		@polls = Poll.all.order(:end_date => :desc).page params[:page]

	end

	def show


		@poll = Poll.find params[:id]

		respond_to do |format|
			format.html {render "show"}

		end


		
	end

	def new

		@poll = Poll.new

		@poll.questions.build


	end

	def create
		
		@poll      = Poll.new standard_attributes
		@poll.user = current_user
		add_terms params["terms-id"], @poll
		@poll.vote_access = params[:vote_access]
		if @poll.save
			flash[:notice] =  'Poll was successfully created.' 
			redirect_to @poll
		else 
			render "new"
		end

	end

	def edit

		@poll = Poll.find params[:id]

		
	end

	def update

		@poll = Poll.find params[:id]
		add_terms params["terms-id"], @poll
		@poll.vote_access = params[:vote_access]
		if @poll.update_attributes standard_attributes
			redirect_to @poll
			flash[:notice] =  'Poll was successfully updated.'

		else

			render "edit"

		end


		
	end

	def destroy

		@poll = Poll.find params[:id]

		if @poll.destroy
			redirect_to polls_path
			flash[:warning] =  'Poll was successfully destroyed.'
		end
		
	end



	private

	def standard_attributes

		
		params.require(:poll).permit(:title,:description, 
									 :start_date, :end_date,
									 :questions_attributes => [:matter, :id, :_destroy])

	end





end