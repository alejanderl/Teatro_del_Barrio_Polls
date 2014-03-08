#encoding: utf-8
describe "Polls testing"   do
  
  before :each do
    create_sample_users
    

  end
  
  
  it "logged user create a poll " , :js do


  	user_login "admin@example.com", "admin123"

    debugger
  	luis = "hola"
  	click_link "Votaciones"

  	click_link "Nuevo"
    debugger
    fill_in "poll_title", :with => "Título de la votación"
    fill_in "poll_description", :with => "Descripción de la votación"
    fill_in "poll_start_date", :with => Time.now
    fill_in "poll_end_date", :with => Time.now + 1.month
    
    4.times do 
      click_link "add_question"
    end

    within "#questions" do
      
      all(:xpath ,".//input[@type='text']").each_with_index do |element, index|

        
        element.set "Pregunta #{index.to_i + 1}"
      end
    end

    click_button "Guardar"
    
    

    page.should have_content "Título de la votación"
    page.should have_content "Pregunta 5"

  end



end