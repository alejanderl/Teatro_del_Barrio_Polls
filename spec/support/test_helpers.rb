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

  def create_user attrs = {}

    attrs2 = attrs.dup
    random = Random.rand(42-10)
    attrs2[:email]  = attrs[:email] || "email#{random}@localhost.es"
    attrs2[:password] = attrs[:password] || "password"
    attrs2[:password_confirmation]  = attrs[:password_confirmation] || "password"
    attrs2[:admin]  =  attrs[:admin] || false
    attrs2[:confirmed_at] =  attrs[:confirmed_at] || Time.now
    attrs2.delete :member
    user = User.new attrs2
    
    user.build_membership if attrs[:member]

    user.save
    user

  end

  def create_sample_users

    create_user(:email => "member@example.com",
            :password => "member123",
            :password_confirmation => "member123",
            :admin => false ,
            :member => true,
            :confirmed_at => Time.now         
            )

    create_user(:email => "admin@example.com",
    			  :password => "admin123",
    			  :password_confirmation => "admin123",
            :admin => true,
            :confirmed_at => Time.now      
    			  )
   
  end




  def create_poll (attrs = {})

    attrs2 = attrs.dup
    random = Random.rand(42-10)
    attrs2[:title]       = attrs[:title]      || "Título de prueba #{random}  "
    attrs2[:description] = attrs[:title]      || "descripción de prueba #{random}  "
    attrs2[:start_date]  = attrs[:start_date] || (Time.now - 1.hour)
    attrs2[:end_date]    = attrs[:end_date]   || (Time.now + 2.days)
    attrs2[:user_id]     = attrs[:user_id]    || User.where(:admin => "1").first.id
    poll = Poll.new attrs2
    questions   = attrs[:questions]  || [{:poll => poll}]

    questions.each do |question|
      create_question question
    end
    
    poll.save
    # return the created object
    poll
  end

  def create_question attrs = {}

    attrs2 = attrs.dup
    random = Random.rand(42-10)
    attrs2[:poll] = attrs[:poll] || Poll.first
    attrs2[:matter]  = attrs[:matter]  || "pregunta de prueba #{random}  "
    
    question = attrs2[:poll].questions.build attrs2 
    question.save
    question


  end

  def create_term attrs = {}
    
    attrs2 = attrs.dup
    random = Random.rand(1000-12)
    attrs2[:name]    = attrs[:name]               || "term #{random}  "
    attrs2[:parent_id]  = attrs[:parent_id]       || Term.first.id
    attrs2[:taxonomy_id]  = attrs[:taxonomy_id]   || Taxonomy.first.id

    Term.create attrs2

  end

end