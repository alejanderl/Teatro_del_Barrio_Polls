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
		if @poll.save
			redirect_to @poll
		else 
			debugger
			render "new"
		end
		
	end

	def edit

		@poll = Poll.find params[:id]
		
	end

	def update

		Poll.update_attributes standard_attributes
		
	end

	def destroy

		@poll = Poll.find params[:id]

		@poll.destroy
		
	end


	private

	def standard_attributes
		params.require(:poll).permit(:title,:description, 
									 :start_date, :end_date,
									 :questions_attributes => [:matter])

	end
end