# encoding: utf-8

module TestHelpers

  def test_sign_in(user)

    user.id = 1
    controller.sign_in(user)

  end

  def user_login (email, password)

    visit new_user_session_path
    fill_in "user_email"   , :with => email
    fill_in "user_password", :with => password  
    click_button "Entrar" 
  	# fakes current user in test scope
    @current_user = User.find_by_email email

  end

  def create_sample_users

    user_member ||= User.create(:email => "member@example.com",
            :password => "member123",
            :password_confirmation => "member123",
            :admin => false ,
            :confirmed_at => Time.now         
            )

    user_admin ||= User.create(:email => "admin@example.com",
    			  :password => "admin123",
    			  :password_confirmation => "admin123",
            :admin => true,
            :confirmed_at => Time.now      
    			  )
   
  end




  def create_poll (attrs = {})

    attrs2 = attrs.dup
    random = Random.rand(42-10)
    attrs2[:title]       = attrs[:title] || "Título de prueba #{random}  "
    attrs2[:description] = attrs[:title] || "descripción de prueba #{random}  "
    attrs2[:start_date]  = attrs[:start_date] || (Time.now - 1.hour)
    attrs2[:end_date]    = attrs[:end_date]   || (Time.now + 1.day)
    attrs2[:user_id]     = attrs[:user_id]    || User.where(:admin => "1").first.id
    poll = Poll.create attrs2
    questions   = attrs[:questions]  || [{:poll_id => poll.id}]

    questions.each do |question|
      create_question question
    end


  end

  def create_question attrs = {}

    attrs2 = attrs.dup
    random = Random.rand(42-10)
    attrs2[:poll_id] = attrs[:poll_id] || Poll.first.id
    attrs2[:matter]  = attrs[:matter]  || "pregunta de prueba #{random}  "
    
    question = Poll.find(attrs[:poll_id]).questions.build attrs2 
    question.save


  end

end