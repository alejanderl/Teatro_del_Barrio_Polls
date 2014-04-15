module PollsHelper

  def status_badge poll
    case poll.state
    when 0
      css_class = "warning"
      status    = "close"
    when 1
      css_class = "success"
      status    = "open"
    when 2
      css_class = "info"
      status    = "programmed"
    end
    render "polls/labels/status_badge", :css_class => css_class, :status => status, poll: poll
  end

  def status_class poll
    case poll.state
    when 0
      css_class = "warning"
      status    = "close"
    when 1
      css_class = "success"
      status    = "open"
    when 2
      css_class = "info"
      status    = "programmed"
    end
    css_class
  end
  def enforceable_poll poll

    render "polls/labels/enforceable" if poll.enforceable

  end

  def priority_poll poll

    render "polls/labels/priority" if poll.priority&&poll.open?
  end

  def voting_buttons question
    render "questions/voting_buttons", question: question
  end

  def can_vote? question

    question.poll.can_vote?(current_user)&&!public_user_has_vote?(question)
  end


  def public_user_has_vote? question


    questions_voted = {}
    questions_voted =  Marshal.load(session[:questions_voted]) if current_user.nil?&&!session[:questions_voted].nil?

    (questions_voted.has_key? question.id.to_s) ?  questions_voted[question.id.to_s] : false

  end

end

