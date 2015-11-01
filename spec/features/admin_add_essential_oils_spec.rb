require 'spec_helper'

feature 'Admin Add Essential Oils' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete essential_oils" do
    
    set_categories
    visit home_path
    # Add essential_oils
    essential_oil1 = add_new_essential_oil()
    check_essential_oil_pages(essential_oil1)
    essential_oil2 = add_new_essential_oil()
    check_essential_oil_pages(essential_oil2)
    essential_oil3 = add_new_essential_oil()
    check_essential_oil_pages(essential_oil3)
    essential_oil4 = add_new_essential_oil()
    check_essential_oil_pages(essential_oil4)
    # Updates
    update_essential_oil_attribute(essential_oil1, 'name', 'Gold Flower Of Life')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'name', 'Gold Flower Of Life')
 
    update_essential_oil_attribute(essential_oil1, 'english_name', 'tahini')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'english_name', 'Tahini')

    update_essential_oil_attribute(essential_oil1, 'price_5ml', '200')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'price_5ml', 200)
 
    update_essential_oil_attribute(essential_oil1, 'price_10ml', '20')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'price_10ml', 20)

    update_essential_oil_attribute(essential_oil1, 'price_50ml', '70')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'price_50ml', 70)

    update_essential_oil_attribute(essential_oil1, 'use_instructions', 'this is how you use the essential_oils')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'use_instructions', 'this is how you use the essential_oils')

    update_essential_oil_attribute(essential_oil1, 'warnings', 'very very (NOT) dangerous')
    check_essential_oil_attribute_and_return_old_value(essential_oil1, 'warnings', 'very very (NOT) dangerous')
 
    test_essential_oil_image_update(essential_oil1)
    # Delete
    #delete_essential_oil(essential_oil1)
    #expect(essential_oil.count).to eq(3)

  end

  def add_new_essential_oil()
    essential_oil_attr = Fabricate.attributes_for(:essential_oil)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "שמנים אתריים"
    click_link 'הוסף שמן אתרי חדש לאתר'

    fill_in 'essential_oil_name', with: essential_oil_attr[:name]
    fill_in 'essential_oil_english_name', with: essential_oil_attr[:english_name]
    attach_file "*תמונה:", "spec/support/uploads/product.jpg"
  
    fill_in 'essential_oil_price_5ml', with: essential_oil_attr[:price_5ml]  
    fill_in 'essential_oil_price_10ml', with: essential_oil_attr[:price_10ml] 
    fill_in 'essential_oil_price_50ml', with: essential_oil_attr[:price_50ml] 

    fill_in 'essential_oil_use_instructions', with: essential_oil_attr[:use_instructions]
    fill_in 'essential_oil_warnings', with: essential_oil_attr[:warnings]
    
    page.find('#essential-oil-form-submit').click
    return EssentialOil.last
  end

  def check_essential_oil_pages(essential_oil)
    #Check Index Page
    main_menu = page.find('.store-main-menu')
    main_menu.click_link 'שמנים אתריים'
    expect(page).to have_content essential_oil.name
    expect(page).to have_content (essential_oil.price_5ml.round)
    expect(page).to have_css ("img[src$='#{essential_oil.image}']")
    #Check essential_oil Page
    click_link essential_oil.name
    essential_oil_info = page.find('.product-info')
    expect(essential_oil_info).to have_content essential_oil.name
    expect(essential_oil_info).to have_content (essential_oil.price_5ml.round)
    expect(essential_oil_info).to have_css ("img[src$='#{essential_oil.image}']")
    expect(essential_oil_info).to have_content essential_oil.use_instructions
    expect(essential_oil_info).to have_content essential_oil.warnings
  end

  def update_essential_oil_attribute(essential_oil, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "שמנים אתריים"
    find("a[href='/admin/essential_oils/#{essential_oil.slug}/edit']").click
    fill_in "essential_oil_#{attribute}", with: value
    page.find('#essential-oil-form-submit').click
  end

  def check_essential_oil_attribute_and_return_old_value(essential_oil, attribute, value)
    essential_oil_from_db = EssentialOil.find(essential_oil.id)
    expect(essential_oil_from_db.name).to eq(essential_oil.name) unless attribute == 'name'
    expect(essential_oil_from_db.english_name).to eq(essential_oil.english_name) unless attribute == 'english_name'
    expect(essential_oil_from_db.price_5ml).to eq(essential_oil.price_5ml) unless attribute == 'price_5ml'   
    expect(essential_oil_from_db.price_10ml).to eq(essential_oil.price_10ml) unless attribute == 'price_10ml'   
    expect(essential_oil_from_db.price_50ml).to eq(essential_oil.price_50ml) unless attribute == 'price_50ml'         
    expect(essential_oil_from_db.use_instructions).to eq(essential_oil.use_instructions) unless attribute == 'use_instructions'   
    expect(essential_oil_from_db.warnings).to eq(essential_oil.warnings) unless attribute == 'warnings'

    if attribute
      expect(essential_oil_from_db[attribute.to_sym]).to eq(value)
      essential_oil_from_db.update_attribute(attribute.to_sym, essential_oil[attribute.to_sym])
    end
  end
  
  def test_essential_oil_image_update(essential_oil)
    expect(essential_oil.reload.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "שמנים אתריים"
    find("a[href='/admin/essential_oils/#{essential_oil.slug}/edit']").click
    attach_file "*תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#essential-oil-form-submit').click
    expect(EssentialOil.find(essential_oil.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_essential_oil(essential_oil)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "שמנים אתריים"
    find("a[href='/admin/essential_oils/#{essential_oil.slug}']").click
  end

end