require 'spec_helper'

feature 'Admin Add MedicinalHerbs' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete medicinal_herbs" do

    set_categories
    visit home_path
    # Add Medicinal Herbs
    rosemary = add_new_medicinal_herb()
    check_medicinal_herb_pages(rosemary)

    garlic = add_new_medicinal_herb()
    check_medicinal_herb_pages(garlic)

    lemon = add_new_medicinal_herb()
    check_medicinal_herb_pages(lemon)

    lemon_grass = add_new_medicinal_herb()
    check_medicinal_herb_pages(lemon_grass)
    # Updates
    update_medicinal_herb_attribute(rosemary, 'name', 'Gold Flower Of Life')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'name', 'Gold Flower Of Life')
 
    update_medicinal_herb_attribute(rosemary, 'english_name', 'disinfects_wounds')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'english_name', 'Disinfects Wounds')

    update_medicinal_herb_attribute(rosemary, 'latin_name', 'latinato')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'latin_name', 'latinato')

    update_medicinal_herb_attribute(rosemary, 'medicinal_properties', 'can cure everything')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'medicinal_properties', 'can cure everything')
 
    update_medicinal_herb_attribute(rosemary, 'use_instructions', 'eat the leafs')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'use_instructions', 'eat the leafs')

    update_medicinal_herb_attribute(rosemary, 'warnings', 'can makes you fall in love')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'warnings', 'can makes you fall in love')

    update_medicinal_herb_attribute(rosemary, 'other_qualities', 'will make you reach')
    check_medicinal_herb_attribute_and_return_old_value(rosemary, 'other_qualities', 'will make you reach')

    test_medisinal_herb_research_links_update(rosemary)
    test_medicinal_herb_image_update(rosemary)
    test_medicinal_herb_sprout_image_update(rosemary)
    # Delete
    #expect(MedicinalHerb.count).to eq(4)
    #delete_medicinal_herb(rosemary)
    #expect(MedicinalHerb.count).to eq(3)
  end

  def add_new_medicinal_herb()
    medicinal_herb_attr = Fabricate.attributes_for(:medicinal_herb)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"
    click_link 'הוסף צמח מרפא לאתר'
    fill_in 'medicinal_herb_name', with: medicinal_herb_attr[:name]
    fill_in 'medicinal_herb_english_name', with: medicinal_herb_attr[:english_name]
    fill_in 'medicinal_herb_latin_name', with: medicinal_herb_attr[:latin_name]
    fill_in 'medicinal_herb_medicinal_properties', with: medicinal_herb_attr[:medicinal_properties]
    fill_in 'medicinal_herb_use_instructions', with: medicinal_herb_attr[:use_instructions]
    fill_in 'medicinal_herb_warnings', with: medicinal_herb_attr[:warnings]
    fill_in 'medicinal_herb_other_qualities', with: medicinal_herb_attr[:other_qualities]
    attach_file 'medicinal_herb_image', "spec/support/uploads/product.jpg"
    attach_file 'medicinal_herb_sprout_image', "spec/support/uploads/product.jpg"

    page.find('#medicinal_herb-form-submit').click
    return MedicinalHerb.last
  end

  def check_medicinal_herb_pages(medicinal_herb)
    main_menu = page.find('.info-main-menu')
    main_menu.click_link 'לפי שם הצמח'
    click_link medicinal_herb.name
    expect(page).to have_content medicinal_herb.name
    expect(page).to have_content medicinal_herb.latin_name
    expect(page).to have_css ("img[src$='#{medicinal_herb.image}']")
    expect(page).to have_css ("img[src$='#{medicinal_herb.sprout_image}']")
    expect(page).to have_content medicinal_herb.medicinal_properties
    expect(page).to have_content medicinal_herb.use_instructions
    expect(page).to have_content medicinal_herb.warnings
    expect(page).to have_content medicinal_herb.other_qualities
  end

  def update_medicinal_herb_attribute(medicinal_herb, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}/edit']").click
    fill_in "medicinal_herb_#{attribute}", with: value
    page.find('#medicinal_herb-form-submit').click
  end

  def check_medicinal_herb_attribute_and_return_old_value(medicinal_herb, attribute, value)
    medicinal_herb_from_db = MedicinalHerb.find(medicinal_herb.id)
    expect(medicinal_herb_from_db.name).to eq(medicinal_herb.name) unless attribute == 'name'
    expect(medicinal_herb_from_db.english_name).to eq(medicinal_herb.english_name) unless attribute == 'english_name'
    expect(medicinal_herb_from_db.latin_name).to eq(medicinal_herb.latin_name) unless attribute == 'latin_name'
    expect(medicinal_herb_from_db.medicinal_properties).to eq(medicinal_herb.medicinal_properties) unless attribute == 'medicinal_properties'   
    expect(medicinal_herb_from_db.use_instructions).to eq(medicinal_herb.use_instructions) unless attribute == 'use_instructions'
    expect(medicinal_herb_from_db.warnings).to eq(medicinal_herb.warnings) unless attribute == 'warnings'         
    expect(medicinal_herb_from_db.other_qualities).to eq(medicinal_herb.other_qualities) unless attribute == 'other_qualities'    
    if attribute
      expect(medicinal_herb_from_db[attribute.to_sym]).to eq(value)
      medicinal_herb_from_db.update_attribute(attribute.to_sym, medicinal_herb[attribute.to_sym])
    end
  end

  def test_medisinal_herb_research_links_update(medicinal_herb)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"    
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}/edit']").click
    
    ['http://tekbang.com/', 'https://tekbang.com/'].each_with_index do |url, index|
      fill_in "medicinal_herb_research_links_#{index}_url", with: url
    end    
    page.find('#medicinal_herb-form-submit').click
    expect(MedicinalHerb.find(medicinal_herb.id).research_links.map{ |x| x[:url]}).to eq(['http://tekbang.com/', 'https://tekbang.com/'])
    
    # Delete one link
    menu.click_link "צמחי מרפא"    
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}/edit']").click
    
    ['https://tekbang.com/', ''].each_with_index do |url, index|
      fill_in "medicinal_herb_research_links_#{index}_url", with: url
    end    
    page.find('#medicinal_herb-form-submit').click
    expect(MedicinalHerb.find(medicinal_herb.id).research_links.map{ |x| x[:url]}).to eq(['https://tekbang.com/'])
  end


  def test_medicinal_herb_image_update(medicinal_herb)
    expect(medicinal_herb.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"    
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}/edit']").click
    attach_file "*תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#medicinal_herb-form-submit').click
    expect(MedicinalHerb.find(medicinal_herb.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def test_medicinal_herb_sprout_image_update(medicinal_herb)
    expect(medicinal_herb.sprout_image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}/edit']").click
    attach_file 'medicinal_herb_sprout_image' , "spec/support/uploads/new_pic.jpg"
    page.find('#medicinal_herb-form-submit').click
    expect(MedicinalHerb.find(medicinal_herb.id).sprout_image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_medicinal_herb(medicinal_herb)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "צמחי מרפא"
    find("a[href='/admin/medicinal_herbs/#{medicinal_herb.slug}']").click
  end

end