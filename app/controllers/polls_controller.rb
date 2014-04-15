class PollsController < ApplicationController
  before_filter :where_is_current_user , only: :show

  def index

    @query = {}

    @query[:published] = true if !current_user||!current_user.admin?
    @query[:status] = params[:status]

    @polls = Poll.find_polls(@query).page(params[:page]).per(params[:per])


  end

  def show


    @poll = Poll.find params[:id]

    @current_user2 = @current_user || User.new

    if @poll.published||@current_user2.admin?

      respond_to do |format|
        format.html {render "show"}
      end


    else

      redirect_to root_path
      flash[:error] =  'Not published.'

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

  def where_is_current_user
    # current_user fails and return nil in the show action- this is a patch
    @current_user = current_user

  end

  def standard_attributes


    params.require(:poll).permit(:title,:description,
                   :start_date, :end_date,
                   :published, :enforceable,
                   :priority,
                   :questions_attributes => [:matter, :id, :_destroy])

  end





end