require 'spec_helper'

feature 'User Checkout Spec' do

  given!(:tahini) { Fabricate(:product, price: 20, stock: 70) }
  given!(:olive_oil) { Fabricate(:product, price: 7, stock: 7) }
  given(:address_attr) { Fabricate.attributes_for(:address) } 

  context 'login user' do

    given(:user) { Fabricate(:user)}

    background do
      sign_in(user)
    end

    scenario "user fill order details" do
      visit home_path
      user_fill_shopping_cart
      check_order_details_fill
    end

    scenario "user checkout successfuly" do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4242424242424242')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Payment was made.'
      expect(Order.count).to eq(1)
    end

    scenario "user checkout with invalid card", js: true, vcr: true do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4242424242424240')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Your card number is incorrect'
      expect(Order.count).to eq(0)
    end

    scenario "user checkout with decline card", js: true, vcr: true do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4000000000000002')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Your card was declined.'
      expect(Order.count).to eq(0)
    end

    scenario "user checkout with item that is out of stock", js: true do

    end
  end

  context 'guest user' do

    scenario "user fill order details", js: true do
      visit home_path
      user_fill_shopping_cart
      check_order_details_fill
    end

    scenario "user checkout successfuly", js: true, vcr: true do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4242424242424242')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Payment was made.'
      expect(Order.count).to eq(1)
    end

    scenario "user checkout with invalid card", js: true, vcr: true do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4242424242424240')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Your card number is incorrect'
      expect(Order.count).to eq(0)
    end

    scenario "user checkout with decline card", js: true, vcr: true do
      visit home_path
      user_fill_shopping_cart
      user_fill_order_details
      fill_payment_form('4000000000000002')
      click_button "Submit Payment"  
      sleep 20
      expect(page).to have_content 'Your card was declined.'
      expect(Order.count).to eq(0)
    end

    scenario "user checkout with item that is out of stock" do

    end
  end

  def user_fill_shopping_cart
    add_product_from_product_page_to_shopping_cart(tahini, 5)
    add_product_from_product_page_to_shopping_cart(olive_oil, 3)
  end

  def add_product_from_product_page_to_shopping_cart(product, qty=1)
    menu = find('#main-menu')
    menu.click_link product.category.name
    find(:xpath, "(//a[@href='/products/#{product.slug}'])[1]").click
    form = find('.product-info')
    form.fill_in 'qty', with: qty
    form.click_button("הוסף לעגלה")
  end

  def check_order_details_fill
    click_link "לקופה"
    # Check the shopping cart details
    expect(page).to have_content tahini.name
    expect(page).to have_content olive_oil.name
    expect(page).to have_content '5' # QTY
    expect(page).to have_content '3' # QTY
    expect(page).to have_content display_price(tahini.price.round*5)
    expect(page).to have_content display_price(olive_oil.price.round*3)
    expect(page).to have_content display_price(tahini.price.round*5 + olive_oil.price.round*3)
    #Check details save
    form = find('#new_address')
    form.fill_in '*שם פרטי:', with: 'Neil'
    form.fill_in '*שם משפחה:', with: 'Young'
    form.fill_in '*כתובת:', with: 'King Gourge 22'
    form.fill_in 'שורה 2:', with: '34/89'
    form.fill_in '*מיקוד:', with: '2345'
    form.fill_in '*טלפון:', with: '987654321'
    form.fill_in '*דואר אלקטרוני:', with: 'neil@young.com'
    click_button 'המשך לתשלום'
    form = find('#new_address')
    form.fill_in '*עיר:', with: 'Tel Aviv'
    click_button 'המשך לתשלום'
    expect(form.find_field('address_first_name').value).to eq 'Neil'
    expect(form.find_field('address_last_name').value).to eq 'Young'
    expect(form.find_field('address_address_line1').value).to eq 'King Gourge 22'
    expect(form.find_field('address_address_line2').value).to eq '34/89'
    expect(form.find_field('address_postal_code').value).to eq '2345'
    expect(form.find_field('address_phone_number').value).to eq '987654321'
    expect(form.find_field('address_email').value).to eq 'neil@young.com'
    expect(form.find_field('address_city').value).to eq 'Tel Aviv'
    form = find('#new_address')
    form.check 'accept_terms_and_conditions'
    #click_button 'המשך לתשלום'
    #expect(current_path).to eq(home_path)  
  end

  def user_fill_order_details
    menu = find('.header-links')
    menu.click_link "Checkout"
    form = find('#new_address')
    form.fill_in '*First Name:', with: order_attr[:first_name]
    form.fill_in '*Last Name:', with: order_attr[:last_name]
    form.fill_in '*Address:', with: order_attr[:address_line1]
    form.fill_in '*Postal code:', with: order_attr[:postal_code]
    form.fill_in '*City:', with: order_attr[:city]
    form.fill_in '*Phone:', with: order_attr[:phone_number]
    form.fill_in '*E-mail:', with: order_attr[:email]
    form.select 'Germany' , from: '*Country:'
    form.check 'accept_terms_and_conditions'
    form.click_button 'Submit Payment'
    expect(current_path).to eq(payment_path)
  end

  def fill_payment_form(card_number)
    fill_in "Credit Card Number", with: card_number
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2019", from: "date_year"
  end

end

