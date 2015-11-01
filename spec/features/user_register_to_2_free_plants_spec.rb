require 'spec_helper'

feature "User Register To 2 Free Plants" do

  given(:addr_attr) { Fabricate.attributes_for(:address) }

  scenario "user register to 2 free plants", js: true do
    set_categories
    visit home_path
    click_link 'הרשם לקבלת 2 צמחי מרפא שימושיים'
    find(:css, "#plants_[value='רוזמרין']").set(true)
    find(:css, "#plants_[value='לבנדר']").set(true)
    fill_address_attributes
    find(:css, "#delivery_method_post_mail").set(true)
    click_button 'הכנס לרשימת המתנה'
    sleep(1)
    expect(FreePlantsOrder.count).to eq(1)
    expect(FreePlantsOrder.first.delivery_method).to eq('post mail')
    expect(FreePlantsOrder.first.plant_1).to eq('רוזמרין')
    expect(FreePlantsOrder.first.plant_2).to eq('לבנדר')
  end

  def fill_address_attributes
    form = find('#new_address')
    form.fill_in '*שם פרטי:', with: addr_attr[:first_name]
    form.fill_in '*שם משפחה:', with: addr_attr[:last_name]
    form.fill_in '*כתובת:', with: addr_attr[:address_line1]
    form.fill_in 'שורה 2:', with: addr_attr[:address_line2]
    form.fill_in '*עיר:', with: addr_attr[:city]
    form.fill_in '*מיקוד:', with: addr_attr[:postal_code]
    form.fill_in '*טלפון:', with: addr_attr[:phone_number]
    form.fill_in '*אי מייל:', with: addr_attr[:email]
  end

  def check_address_attributes
    expect(Address.count).to eq(1)
    expect(Address.first.first_name).to eq(addr_attr[:first_name])
    expect(Address.first.last_name).to eq(addr_attr[:last_name])
    expect(Address.first.address_line1).to eq(addr_attr[:address_line1])
    expect(Address.first.address_line2).to eq(addr_attr[:address_line2])
    expect(Address.first.city).to eq(addr_attr[:city])
    expect(Address.first.postal_code).to eq(addr_attr[:postal_code])
    expect(Address.first.phone_number).to eq(addr_attr[:phone_number])
    expect(Address.first.email).to eq(addr_attr[:email])
  end

end