require 'spec_helper'

feature "user forgot password" do

  given(:user) { Fabricate(:user)}

  scenario "user forgot the password and reset it", js: true  do

    set_categories
    visit home_path
    click_link "התחבר" 
    click_link "שכחת את הסיסמה?"

    fill_in "email", with: user.email
    click_button "שלח קישור"
    open_email(user.email)

    current_email.click_link "חדש סיסמה"
    fill_in "password", with: "newpassword"
    click_button "שלח"

    sign_in(user, "newpassword")
    click_link "פרטים אישיים"
    expect(page).to have_content user.name
  end
end