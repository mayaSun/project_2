require 'spec_helper'

feature 'Admin Handle User Orders' do

  after { ActionMailer::Base.deliveries.clear }

  given!(:admin) { Fabricate(:admin) }
  given!(:user) { Fabricate(:user) }
  given!(:product) { Fabricate(:product) }
  given!(:user_order) { Fabricate(:order, user: user, status: 'Paid') }
  given!(:guest_order) { Fabricate(:order, status: 'Paid') }
  given!(:shopping_cart_item1) { Fabricate(:shopping_cart_item, sellable: product, position: user_order) }
  given!(:shopping_cart_item2) { Fabricate(:shopping_cart_item, sellable: product, position: guest_order) }
  
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin handle user order" do

    set_categories
    visit home_path
    
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "הזמנות"
    expect(page).to have_content user.name
    expect(page).to have_content user_order.total_bill.round%100
    expect(page).to have_content guest_order.total_bill.round%100
    # Handle user order
    first("a[href='/admin/orders/#{user_order.slug}/edit']").click
    expect(page).to have_content product.name
    expect(page).to have_content product.price.round
    fill_in 'confirmation_number', with: 'maya123'
    fill_in 'tracking_number' , with: 'shalom765'
    click_button 'submit-order-delivery'
    message = ActionMailer::Base.deliveries.last
    expect(message.to).to eq([user_order.shipping_address.email])
    menu.click_link "הזמנות"
    expect(user_order.reload.status).to eq('Sent')
    expect(user_order.reload.confirmation_number).to eq('maya123')
    expect(user_order.reload.tracking_number).to eq('shalom765')
    expect(page).to have_content 'נשלח'
    # Handle guest order
    first("a[href='/admin/orders/#{guest_order.slug}/edit']").click
    expect(page).to have_content product.name
    expect(page).to have_content product.price.round
    fill_in 'confirmation_number', with: 'gtyh'
    fill_in 'tracking_number' , with: 'shyi'
    click_button 'submit-order-delivery'
    message = ActionMailer::Base.deliveries.last
    expect(message.to).to eq([guest_order.shipping_address.email])
    menu.click_link "הזמנות"
    expect(guest_order.reload.status).to eq('Sent')
    expect(guest_order.reload.confirmation_number).to eq('gtyh')
    expect(guest_order.reload.tracking_number).to eq('shyi')
    # User see order
    click_link 'התנתק'
    sign_in(user)
    click_link 'החשבון שלי'
    menu = find('.user-menu')
    menu.click_link 'סטטוס הזמנות'
    expect(page).to have_content user_order.total_bill.round%100
    find("a[href='/orders/#{user_order.slug}']").click
    expect(page).to have_content 'shalom765'
    expect(page).to have_content product.name
    expect(page).to have_content product.price.round
  end

end