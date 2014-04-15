#encoding: utf-8
require 'spec_helper'

describe "Polls testing"   do

  before :each do
    create_sample_users


  end


  it "logged user create a poll ", :js  do


    user_login "admin@example.com", "admin123"

    Term.where("taxonomy_id > 0").destroy_all
    %w[general reflexiones estado].each do |name|
      create_term :name => name
    end

    visit polls_path
    href="/es/polls/new"

    first(:xpath, "//a[@href='#{new_poll_path}']").click

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

    # Also testing adding terms

    within ".taxonomy-terms" do
      first(".open-dialog").click
    end
    term = Term.last
    within ".term-#{term.id}" do

      first("a").click

    end

    click_button "Close"
    click_button "Guardar"

    page.should have_content "Título de la votación"
    page.should have_content "Pregunta 5"
    page.should have_content term.name

  end


  it "Members can vote yes, no and change their vote"   do
    poll = create_poll
    user_login "member@example.com", "member123"
    visit poll_path(poll.id, :locale => :es)



     #vote yes
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'yes', locale: :es)}']").click
    page.should have_content "Has votado si"
    within ".vote-results" do
      within ".votes-yes" do
        page.should have_content "1"
      end
    end

    #change_vote
    click_link "Cambiar mi voto"
    page.should_not have_content "Has votado si"
    within ".vote-results" do
      within ".votes-yes" do
        page.should have_content "0"
      end
    end

    #vote_no
    find(:xpath, "//a[@href='#{voting_path(poll.questions.first, 'no', locale: :es)}']").click
    page.should have_content "Has votado no"
    within ".vote-results" do
      within ".votes-no" do
        page.should have_content "1"
      end
    end
  end

  it "Members can not vote expired polls"   do
    Delorean.time_travel_to "1 month ago"
    create_poll :start_date => (Time.now - 7.days), :end_date => (Time.now  + 12.days)
    Delorean.back_to_the_present
    user_login "member@example.com", "member123"

    visit poll_path(Poll.last.id, :locale => :es)
    page.should have_content("Cerrada")

    page.should have_content("No has votado")

  end

  it "Members can not vote programmed polls"   do

    create_poll :start_date => (Time.now  + 7.days), :end_date => (Time.now  + 12.days)

    user_login "member@example.com", "member123"

    visit poll_path(Poll.last.id, :locale => :es)
    page.should have_content("Programada")

    page.should have_content("No has votado")

  end



  it "polls should have right dates on saving"   , :js do

    poll = create_poll
    user_login "admin@example.com", "admin123"
    visit edit_poll_path poll, :locale => :es
    fill_in "poll_end_date", :with => "2013-1-12"

    click_button "Guardar"
    page.should have_content "futuro"
    page.should have_css ".alert-danger"
    fill_in "poll_start_date", :with => (Date.today + 4.days)
    fill_in "poll_end_date", :with => (Date.today + 2.days)
    click_button "Guardar"
    page.should have_content "debe ser mayor"
    page.should have_css ".alert-danger"

  end

  it "public user/ guest user can access to draft polls"  do

    poll = create_poll title: "Borrador", published: false

    user_login "guest@example.com", "guest123"
    visit poll_path poll, locale: :es
    page.should have_content "Not published"
    page.should_not have_content "Borrador"

    user_logout
    visit poll_path poll, locale: :es
    page.should have_content "Not published"
    page.should_not have_content "Borrador"
  end
  it "draft polls are not listed to public or guests" do

    6.times do |number|
      create_poll title: "Publicada #{number}"
    end
    poll = create_poll title: "Borrador", published: false

    visit root_path locale: :es
    page.should have_content "Publicada 0"
    page.should have_content "Publicada 5"
    page.should_not have_content "Borrador"

    user_login "guest@example.com", "guest123"
    visit root_path locale: :es
    page.should have_content "Publicada 0"
    page.should have_content "Publicada 5"
    page.should_not have_content "Borrador"


  end
  it "admin can edit draft polls" , :js do
    poll = create_poll title: "Borrador", published: false
    user_login "admin@example.com", "admin123"

    visit poll_path poll, locale: :es
    page.should have_content "Borrador"
    click_link "Editar"
    fill_in :poll_title , with: "Borrador editado"
    click_button "Guardar"
    page.should have_content "Borrador"
    page.should have_content "Borrador editado"

    click_link "Editar"
    fill_in :poll_title , with: "Encuesta editada"
    fill_in :poll_description, with: "Descripcion editada"
    first("[for='poll_published']").click
    click_button "Guardar"

    page.should have_content "Encuesta editada"
    page.should_not have_content "Borrador"



  end

  it "admin cannot vote draft polls"  do

    poll = create_poll title: "Borrador", published: false
    user_login "admin@example.com", "admin123"
    visit poll_path poll , locale: :es


    page.should_not have_xpath "//a[@href='#{voting_path(poll.questions.first, 'no', locale: :es)}']"
    page.should_not have_content "No has votado"


  end

  it "set poll as enforceable", :js do

    poll = create_poll

    user_login "admin@example.com", "admin123"
    visit edit_poll_path poll, locale: :es
    first("[for='poll_enforceable']").click
    click_button "Guardar"
    page.should have_css ".glyphicon-bookmark"
    visit polls_path
    page.should have_content "Vinculante"

  end


  it "set poll as priority and show to user only in cases take case", :js do
    Delorean.time_travel_to "1 month ago"
    poll = create_poll

    user_login "admin@example.com", "admin123"
    visit edit_poll_path poll, locale: :es
    first("[for='poll_priority']").click
    click_button "Guardar"
    page.should have_css ".glyphicon-send"
    page.should have_content "Prioritaria"

    #Programmed polls should not show priority
    Delorean.time_travel_to "6 month ago"
    visit poll_path poll, locale: :es
    page.should_not have_css ".glyphicon-send"
    page.should_not have_content "Prioritaria"

    #Closed polls should not show priority
    Delorean.back_to_the_present
    visit poll_path poll, locale: :es
    page.should_not have_css ".glyphicon-send"
    page.should_not have_content "Prioritaria"


  end


end