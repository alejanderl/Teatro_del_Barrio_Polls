class VotesController < ApplicationController

  before_filter :check_if_user_has_vote , only:[:create]
  helper_method :check_if_user_has_vote

  def create

    question = Question.find params[:question_id]
    if question.vote! current_user, params[:my_vote]
      flash[:notice] = "Thanks for voting".t
      redirect_to poll_path(question.poll , anchor: "question-#{question.id}")
    else
      flash[:error] = "There_was_an_error".t
      redirect_to poll_path(question.poll , anchor: "question-#{question.id}")
    end

  end

  def destroy

    question = Question.find params[:question_id]
    if question.destroy_vote! current_user
      flash[:notice] = "Now you can vote again".t
    else
      flash[:error] = "There_was_an_error".t
    end

    redirect_to poll_path(question.poll , anchor: "question-#{question.id}")

  end


  private
  def check_if_user_has_vote
    unless current_user
      questions_voted = session[:questions_voted] ? Marshal.load(session[:questions_voted]) : {}

      if questions_voted.has_key? params[:question_id]
        flash[:error] = "You can not vote twice this question".t
        redirect_to root_path
        return false
      else
        questions_voted[params[:question_id]] = params[:my_vote]
        session[:questions_voted] = Marshal.dump questions_voted
      end
    end
  end

end