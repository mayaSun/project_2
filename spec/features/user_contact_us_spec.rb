require 'spec_helper'

feature "User Contact Us" do

  scenario "user contact us" do
    ActionMailer::Base.deliveries.clear

    set_categories
    visit home_path
    click_link 'כתוב לנו'
    form =  find("form[action='/contact_us']") 
    form.fill_in 'name', with: 'ישראל ישראלי'
    form.fill_in 'email', with: 'israel@gmail.com'
    form.fill_in 'subject', with: 'שלום רב לצוות ההנהלה'
    form.find('#contact_us-form-submit').click 
    expect(page).to have_content("אנה מלא תוכן פניתך")
    form.fill_in 'message', with: 'שלום רב יש לי המון מה לאמר ולכן שלכתי הודעה'
    form.find('#contact_us-form-submit').click
    expect(ActionMailer::Base.deliveries.last.body).to have_content('שלום רב יש לי המון מה לאמר ולכן שלכתי הודעה')
    ActionMailer::Base.deliveries.clear
  end

end