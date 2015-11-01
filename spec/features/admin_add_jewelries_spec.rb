require 'spec_helper'

feature 'Admin Add jewelries' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete jewelries" do
    
    set_categories

    diamond = Fabricate(:crystal)
    ruby = Fabricate(:crystal)
    cat_eye = Fabricate(:crystal)
    merkaba = Fabricate(:crystal)
    
    visit home_path
    # Add jewelries
    jewelry1 = add_new_jewelry([diamond.id, ruby.id, cat_eye.id, merkaba.id])
    check_jewelry_pages(jewelry1, [diamond.id, ruby.id, cat_eye.id, merkaba.id])
    jewelry2 = add_new_jewelry([diamond.id, merkaba.id])
    check_jewelry_pages(jewelry2, [diamond.id, merkaba.id])
    jewelry3 = add_new_jewelry([merkaba.id])
    check_jewelry_pages(jewelry3, [merkaba.id])
    jewelry4 = add_new_jewelry([diamond.id, merkaba.id])
    check_jewelry_pages(jewelry4, [diamond.id, merkaba.id])
    # Updates
    update_jewelry_attribute(jewelry1, 'name', 'Gold Flower Of Life')
    check_jewelry_attribute_and_return_old_value(jewelry1, 'name', 'Gold Flower Of Life')
 
    update_jewelry_attribute(jewelry1, 'english_name', 'tahini')
    check_jewelry_attribute_and_return_old_value(jewelry1, 'english_name', 'tahini')

    update_jewelry_attribute(jewelry1, 'price', '20000')
    check_jewelry_attribute_and_return_old_value(jewelry1, 'price', 20000)
 

    update_jewelry_attribute(jewelry1, 'long_description', 'this is a very long description')
    check_jewelry_attribute_and_return_old_value(jewelry1, 'long_description', 'this is a very long description')

    test_jewelry_crystal_update(jewelry2, ruby)
    test_jewelry_crystals_update(jewelry1, [merkaba.id, cat_eye.id, diamond.id])
    test_jewelry_image_update(jewelry1)
    # Delete
    #delete_jewelry(jewelry1)
    #expect(jewelry.count).to eq(3)

  end

  def add_new_jewelry(crystal_ids)
    jewelry_attr = Fabricate.attributes_for(:jewelry)
    crystal = Fabricate(:crystal)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "תכשיטים"
    click_link 'הוסף תכשיט חדש לאתר'

    fill_in 'jewelry_name', with: jewelry_attr[:name]
    fill_in 'jewelry_english_name', with: jewelry_attr[:english_name]
    select crystal.name , from: 'jewelry_crystal_id' 
    attach_file "*תמונה:", "spec/support/uploads/product.jpg"
  
    fill_in 'jewelry_price', with: jewelry_attr[:price]  

    fill_in 'jewelry_long_description', with: jewelry_attr[:long_description]

    crystal_ids.each_with_index do |id, index|
      select Crystal.find(id).name , from: "jewelry_jewelry_crystals_#{index}_crystal_id"
      fill_in "jewelry_jewelry_crystals_#{index}_price", with: (100..500).to_a.sample
    end
    
    page.find('#jewelry-form-submit').click
    return Jewelry.last

  end

  def check_jewelry_pages(jewelry, crystal_ids)
    #Check Index Page
    main_menu = page.find('.store-main-menu')
    main_menu.click_link 'תכשיטים רפואיים'
    expect(page).to have_content jewelry.name
    expect(page).to have_content (jewelry.price.round)
    expect(page).to have_css ("img[src$='#{jewelry.image}']")
    #Check jewelry Page
    click_link jewelry.name
    jewelry_info = page.find('.product-info')
    expect(jewelry_info).to have_content jewelry.name
    expect(jewelry_info).to have_content (jewelry.price.round)
    expect(jewelry_info).to have_css ("img[src$='#{jewelry.image}']")
    expect(jewelry_info).to have_content jewelry.long_description
    crystal_ids.each do |id|
      expect(jewelry_info).to have_content(Crystal.find(id).name)    
    end
  end

  def update_jewelry_attribute(jewelry, attribute, value)
    slug = Jewelry.find(jewelry.id).slug
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "תכשיטים"
    find("a[href='/admin/jewelries/#{slug}/edit']").click
    fill_in "jewelry_#{attribute}", with: value
    page.find('#jewelry-form-submit').click
  end

  def check_jewelry_attribute_and_return_old_value(jewelry, attribute, value)
    jewelry_from_db = Jewelry.find(jewelry.id)
    expect(jewelry_from_db.name).to eq(jewelry.name) unless attribute == 'name'
    expect(jewelry_from_db.english_name).to eq(jewelry.english_name) unless attribute == 'english_name'
    expect(jewelry_from_db.long_description).to eq(jewelry.long_description) unless attribute == 'long_description'
    expect(jewelry_from_db.price).to eq(jewelry.price) unless attribute == 'price'   
    expect(jewelry_from_db.jewelry_crystal_ids).to eq(jewelry.jewelry_crystal_ids) unless attribute == 'jewelry_crystal_ids'    
    expect(jewelry_from_db.crystal_id).to eq(jewelry.crystal_id) unless attribute == 'crystal_id' 
    if attribute
      expect(jewelry_from_db[attribute.to_sym]).to eq(value)
      jewelry_from_db.update_attribute(attribute.to_sym, jewelry[attribute.to_sym])
    end
  end

  def  test_jewelry_crystal_update(jewelry, crystal)
    slug = Jewelry.find(jewelry.id).slug
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "תכשיטים"
    find("a[href='/admin/jewelries/#{slug}/edit']").click
    select crystal.name , from: 'jewelry_crystal_id' 
    page.find('#jewelry-form-submit').click
    check_jewelry_attribute_and_return_old_value(jewelry, "crystal_id", crystal.id)
  end

  def test_jewelry_crystals_update(jewelry, crystal_ids)
    expect(Jewelry.find(jewelry.id).jewelry_crystals).to eq(jewelry.jewelry_crystals)
    slug = Jewelry.find(jewelry.id).slug
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "תכשיטים"
    find("a[href='/admin/jewelries/#{slug}/edit']").click
    jewelry.jewelry_crystal_ids.each_with_index do |id, index|
      select 'מחק' , from: "jewelry_jewelry_crystals_#{index}_crystal_id" 
    end 
    crystal_ids.each_with_index do |id, index|
      select Crystal.find(id).name , from: "jewelry_jewelry_crystals_#{index}_crystal_id"
      fill_in "jewelry_jewelry_crystals_#{index}_price", with: index + 100
    end    
    page.find('#jewelry-form-submit').click
    expect(Jewelry.find(jewelry.id).jewelry_crystals.map{ |x| x[:price]}).to eq([100,101,102])
    expect(Jewelry.find(jewelry.id).jewelry_crystals.map{ |x| x[:crystal_id]}).to eq([crystal_ids[0],crystal_ids[1],crystal_ids[2]])

  end
  
  def test_jewelry_image_update(jewelry)
    expect(jewelry.image.url).to eq("/uploads/product.jpg")
    slug = Jewelry.find(jewelry.id).slug
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "תכשיטים"
    find("a[href='/admin/jewelries/#{slug}/edit']").click
    attach_file "*תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#jewelry-form-submit').click
    expect(Jewelry.find(jewelry.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_jewelry(jewelry)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/jewelries/#{jewelry.slug}']").click
  end


end