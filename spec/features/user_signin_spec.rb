require 'spec_helper'

feature "User Signin" do

  given(:shop_owner) { Fabricate(:user, role: 'shop_owner') }
  given(:user_attr) { Fabricate.attributes_for(:user) }

  scenario "user sign up than shop owner make him admin", js: true do
    set_categories
    user = user_sign_up
    check_user_pages(user, user_attr[:password])
    click_link "התנתק"
    sign_in(shop_owner)
    change_user_to_admin(user)
    click_link "התנתק"
    sign_in(user, user_attr[:password])
    expect(page).to have_content "Administration"
  end

  def user_sign_up
    visit home_path
    click_link "התחבר" 
    click_link "הרשם כאן"
    fill_in "שם משתמש:" , with: user_attr[:name]
    fill_in "*אי מייל:", with: user_attr[:email]
    fill_in '*סיסמה:', with: user_attr[:password]
    fill_in "אימות סיסמה:", with: user_attr[:password]
    click_button "הצטרף"
    sleep 1
    return User.last
  end

  def check_user_pages(user,password)
    click_link "החשבון שלי"
    click_link "ערוך"
    fill_in "שם:", with: "Shalom"
    fill_in "אי מייל:", with: "shalom@gmail.com"
    fill_in 'authentication', with: password
    click_button "עדכן פרטים"
    sleep 1
    side_menu = find('.list-group')
    side_menu.click_link "שנה סיסמה"
    fill_in 'authentication', with: password
    fill_in "סיסמה חדשה:", with: "shalomiel"
    fill_in "אימות סיסמה:", with: "shalomiel"
    click_button "שנה סיסמה"
    sleep 1
    user_from_db = User.find(user.id)
    expect(user_from_db.name).to eq("Shalom")
    expect(user_from_db.email).to eq("shalom@gmail.com")
    expect(user_from_db.authenticate("shalomiel")).to_not be(false)
    User.find(user.id).update(name: user.name, email: user.email, password: password)
    # User add address
    addr_attr = Fabricate.attributes_for(:address)
    side_menu.click_link "הכתובות שלי"
    click_link 'הוסף כתובת חדשה'
    form = find('#new_address')
    form.fill_in '*שם פרטי:', with: addr_attr[:first_name]
    form.fill_in '*שם משפחה:', with: addr_attr[:last_name]
    form.fill_in '*כתובת:', with: addr_attr[:address_line1]
    form.fill_in 'שורה 2:', with: addr_attr[:address_line2]
    form.fill_in '*עיר:', with: addr_attr[:city]
    form.fill_in '*מיקוד:', with: addr_attr[:postal_code]
    form.fill_in '*טלפון:', with: addr_attr[:phone_number]
    form.fill_in '*דואר אלקטרוני:', with: addr_attr[:email]
    click_button 'שמור'
    address = find('#shipping-addresses')
    expect(address).to have_content(addr_attr[:first_name])
    expect(address).to have_content(addr_attr[:last_name])
    expect(address).to have_content(addr_attr[:address_line1])
    expect(address).to have_content(addr_attr[:address_line2])
    expect(address).to have_content(addr_attr[:city])
    expect(address).to have_content(addr_attr[:postal_code])
    expect(address).to have_content(addr_attr[:phone_number])
    expect(address).to have_content(addr_attr[:email]) 
    address = find('#billing-addresses')
    expect(address).to have_content(addr_attr[:first_name])
    expect(address).to have_content(addr_attr[:last_name])
    expect(address).to have_content(addr_attr[:address_line1])
    expect(address).to have_content(addr_attr[:address_line2])
    expect(address).to have_content(addr_attr[:city])
    expect(address).to have_content(addr_attr[:postal_code])
    expect(address).to have_content(addr_attr[:phone_number])
    expect(address).to have_content(addr_attr[:email]) 
    address.click_link 'מחק' 
    expect(Address.first.billing).to eq(false)
    expect(Address.first.shipping).to eq(true)
    side_menu.click_link "הכתובות שלי"
    find("a[href='/addresses/#{Address.first.slug}/edit']").click
    form.fill_in '*עיר:', with: 'עין אילה'
    click_button 'שמור'
    expect(Address.first.city).to eq('עין אילה')
  end

  def change_user_to_admin(user)
    click_link "Administration"
    menu = find('.admin-menu')
    menu.find('.navbar-toggle').click
    menu.click_link "לקוחות"
    users_table = find('.admin-table')
    tr = users_table.find('tr', text: user.name)
    expect(tr).to have_content (user.email)
    expect(tr).to have_content (user.orders.count)
    tr.select 'admin' , from: 'role'
    tr.click_button 'update'
    sleep 1
    expect(User.find(user.id).role).to eq('admin')
  end

end