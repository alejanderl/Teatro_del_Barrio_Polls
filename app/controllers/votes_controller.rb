class VotesController < ApplicationController


	def create

		
		question = Question.find params[:question_id]
		
		if question.vote! current_user, params[:my_vote]
			flash[:notice] = "Thanks for voting".t 
			redirect_to question.poll

		else
			flash[:error] = "There_was_an_error".t 
			redirect_to question.poll
			
		end

	end

	def destroy
		question = Question.find params[:question_id]

		if question.destroy_vote! current_user

			redirect_to question.poll

		else

			redirect_to question.poll
			
		end



	end





end