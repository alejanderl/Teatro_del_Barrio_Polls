class VotesController < ApplicationController


	def create
		
		question = Question.find params[:question_id]

		if question.vote! current_user, params[:my_vote]

			redirect_to question.poll

		else

			redirect_to question.poll
		end

	end





end