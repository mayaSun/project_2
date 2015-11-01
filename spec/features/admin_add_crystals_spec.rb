require 'spec_helper'

feature 'Admin Add Crystals' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete crystals" do

    set_categories
    visit home_path
    # Add Crystals
    ruby = add_new_crystal()
    check_crystal_pages(ruby)
    cat_eye = add_new_crystal()
    check_crystal_pages(cat_eye)
    diamond = add_new_crystal()
    check_crystal_pages(diamond)
    odem = add_new_crystal()
    check_crystal_pages(odem)
    # Updates
    update_crystal_attribute(ruby, 'name', 'Gold Flower Of Life')
    check_crystal_attribute_and_return_old_value(ruby, 'name', 'Gold Flower Of Life')
 
    update_crystal_attribute(ruby, 'english_name', 'tahini')
    check_crystal_attribute_and_return_old_value(ruby, 'english_name', 'Tahini')

    update_crystal_attribute(ruby, 'hardness', '7')
    check_crystal_attribute_and_return_old_value(ruby, 'hardness', '7')

    update_crystal_attribute(ruby, 'price', '20000')
    check_crystal_attribute_and_return_old_value(ruby, 'price', 20000)

    update_crystal_attribute(ruby, 'image_link', 'https://github.com/stympy/faker')
    check_crystal_attribute_and_return_old_value(ruby, 'image_link', 'https://github.com/stympy/faker')

    update_crystal_attribute(ruby, 'qualities', 'this is a very long description')
    check_crystal_attribute_and_return_old_value(ruby, 'qualities', 'this is a very long description')

    update_crystal_attribute(ruby, 'use_instructions', 'this is how you use the crystals')
    check_crystal_attribute_and_return_old_value(ruby, 'use_instructions', 'this is how you use the crystals')

    update_crystal_attribute(ruby, 'warnings', 'very very (NOT) dangerous')
    check_crystal_attribute_and_return_old_value(ruby, 'warnings', 'very very (NOT) dangerous')
 
    update_crystal_attribute(ruby, 'price', '20000')
    check_crystal_attribute_and_return_old_value(ruby, 'price', 20000)

    update_crystal_attribute(ruby, 'chemical_formula', 'love')
    check_crystal_attribute_and_return_old_value(ruby, 'chemical_formula', 'love')
 
    test_crystal_image_update(ruby)

    # Delete
    #delete_crystal(ruby)
    #expect(Crystal.count).to eq(3)
  end

  def add_new_crystal()
    crystal_attr = Fabricate.attributes_for(:crystal)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קריסטלים"
    click_link 'הוסף קריסטל לאתר'

    fill_in 'crystal_name', with: crystal_attr[:name]
    fill_in 'crystal_english_name', with: crystal_attr[:english_name]
    attach_file "תמונה:", "spec/support/uploads/product.jpg"
    fill_in 'crystal_image_link', with: crystal_attr[:image_link]
    fill_in 'crystal_price', with: crystal_attr[:price]   
    fill_in 'crystal_hardness', with: crystal_attr[:hardness]
    fill_in 'crystal_qualities', with: crystal_attr[:qualities]
    fill_in 'crystal_use_instructions', with: crystal_attr[:use_instructions]
    fill_in 'crystal_warnings', with: crystal_attr[:warnings]
    fill_in 'crystal_chemical_formula', with: crystal_attr[:chemical_formula]

    page.find('#crystal-form-submit').click
    return Crystal.last
  end

  def check_crystal_pages(crystal)
    #Check Category Page
    main_menu = page.find('.info-main-menu')
    main_menu.click_link 'קריסטלים'
    expect(page).to have_content crystal.name
    expect(page).to have_css ("img[src$='#{crystal.image.big_thumb}']")
    #Check crystal Page
    click_link crystal.name
    product_info = page.find('.product-info')
    expect(product_info).to have_content crystal.price.round
    expect(product_info).to have_content crystal.hardness
    expect(product_info).to have_content crystal.qualities
    expect(product_info).to have_content crystal.use_instructions
    expect(product_info).to have_content crystal.warnings
    expect(product_info).to have_content crystal.chemical_formula

  end

  def update_crystal_attribute(crystal, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קריסטלים"
    find("a[href='/admin/crystals/#{crystal.slug}/edit']").click
    fill_in "crystal_#{attribute}", with: value
    page.find('#crystal-form-submit').click
  end

  def check_crystal_attribute_and_return_old_value(crystal, attribute, value)
    crystal_from_db = Crystal.find(crystal.id)
    expect(crystal_from_db.name).to eq(crystal.name) unless attribute == 'name'
    expect(crystal_from_db.english_name).to eq(crystal.english_name) unless attribute == 'english_name'
    expect(crystal_from_db.hardness).to eq(crystal.hardness) unless attribute == 'hardness'
    expect(crystal_from_db.price).to eq(crystal.price) unless attribute == 'price'     
    expect(crystal_from_db.qualities).to eq(crystal.qualities) unless attribute == 'qualities'   
    expect(crystal_from_db.use_instructions).to eq(crystal.use_instructions) unless attribute == 'use_instructions'  
    expect(crystal_from_db.warnings).to eq(crystal.warnings) unless attribute == 'warnings'
    expect(crystal_from_db.chemical_formula).to eq(crystal.chemical_formula) unless attribute == 'chemical_formula'
    expect(crystal_from_db.image_link).to eq(crystal.image_link) unless attribute == 'image_link'

    if attribute
      expect(crystal_from_db[attribute.to_sym]).to eq(value)
      crystal_from_db.update_attribute(attribute.to_sym, crystal[attribute.to_sym])
    end
  end

  def test_crystal_image_update(crystal)
    expect(crystal.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'קריסטלים'
    find("a[href='/admin/crystals/#{crystal.slug}/edit']").click
    attach_file "תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#crystal-form-submit').click
    expect(Crystal.find(crystal.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_crystal(crystal)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קריסטלים"
    find("a[href='/admin/crystals/#{crystal.slug}']").click
  end

end