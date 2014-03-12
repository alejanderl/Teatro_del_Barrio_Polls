class PollsController < ApplicationController

	def index
		@polls = Poll.all
	end

	def show


		@poll = Poll.find params[:id]

		
	end

	def new

		@poll = Poll.new

		@poll.questions.build


	end

	def create
		
		@poll      = Poll.new standard_attributes
		@poll.user = current_user
		add_terms params["terms-id"], @poll
		if @poll.save
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
		if @poll.update_attributes standard_attributes
			redirect_to @poll

		else

			render "edit"

		end


		
	end

	def destroy

		@poll = Poll.find params[:id]

		@poll.destroy

		
	end



	private

	def standard_attributes

		
		params.require(:poll).permit(:title,:description, 
									 :start_date, :end_date,
									 :questions_attributes => [:matter, :id, :_destroy])

	end

end