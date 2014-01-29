class PollsController < ApplicationController

	def index
		@polls = Poll.all

	end

	def show

		@poll = Poll.find params[:id]

		
	end
	def new

		@poll = Poll.new

	end
	def create


		
	end
	def edit

		@poll = Poll.find params[:id]
		
	end
	def update

		
	end
	def destroy

		@poll = Poll.find params[:id]

		@poll.destroy
		
	end
end