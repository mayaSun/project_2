require 'spec_helper'

feature 'User Search Something' do

  given!(:product) { Fabricate(:product, name: 'טחינה', english_name: 'tahini') }
  given!(:crystal) { Fabricate(:crystal, name: 'עין החתול', english_name: 'cat eye') }
  given!(:medicinal_herb) { Fabricate(:medicinal_herb, name: 'רוזמרי', english_name: 'rosemary', latin_name: 'rosmerica latinica') } 
  given!(:medical_activity) { Fabricate(:medical_activity, name: 'משמח', english_name: 'make happy') }
  given!(:active_ingredient) { Fabricate(:active_ingredient, name: 'טרפנטין', english_name: 'turpentine') }
  given!(:product1) { Fabricate(:product, name: 'זיתים', english_name: 'olives') }
  given!(:crystal1) { Fabricate(:crystal, name: 'רובי', english_name: 'ruby') }
  given!(:medicinal_herb1) { Fabricate(:medicinal_herb, name: 'נענע', english_name: 'mint', latin_name: 'mintica  latinica') } 
  given!(:medical_activity1) { Fabricate(:medical_activity, name: 'ממריץ', english_name: 'energize') }
  given!(:active_ingredient1) { Fabricate(:active_ingredient, name: 'סוכר', english_name: 'suger') }

  scenario 'user search' do
    set_categories
    visit home_path
    # Search Product
    enter_search_term('טחינ')
    expect_page_to_have_product_details(product)
    expect(page).to_not have_content product1.name
    enter_search_term('ives')
    expect_page_to_have_product_details(product1)
    expect(page).to_not have_content product.name
    # Search crystal
    enter_search_term('תול')
    expect_page_to_have_crystal_or_herb(crystal)
    expect(page).to_not have_content crystal1.name
    enter_search_term('ruby')
    expect_page_to_have_crystal_or_herb(crystal1)
    expect(page).to_not have_content crystal.name
    # Search herb
    enter_search_term('נענ')
    expect_page_to_have_crystal_or_herb(medicinal_herb1)
    expect(page).to_not have_content medicinal_herb.name
    enter_search_term('ros')
    expect_page_to_have_crystal_or_herb(medicinal_herb)
    expect(page).to_not have_content medicinal_herb1.name
    enter_search_term('latinica')
    expect_page_to_have_crystal_or_herb(medicinal_herb) 
    expect_page_to_have_crystal_or_herb(medicinal_herb1)  
    # Search Medical Activity
    enter_search_term('משמ')
    expect(page).to have_content medical_activity.name
    expect(page).to_not have_content medical_activity1.name
    enter_search_term('ener')
    expect(page).to have_content medical_activity1.name
    expect(page).to_not have_content medical_activity.name
    # Search Active Ingredient
    enter_search_term('טרפ')
    expect(page).to have_content active_ingredient.name
    expect(page).to_not have_content active_ingredient1.name
    enter_search_term('suge')
    expect(page).to have_content active_ingredient1.name
    expect(page).to_not have_content active_ingredient.name
    # Multiple Search
    enter_search_term('ר')
    expect_page_to_have_crystal_or_herb(medicinal_herb)
    expect_page_to_have_crystal_or_herb(crystal1)  
    expect(page).to have_content active_ingredient.name
    expect(page).to have_content active_ingredient1.name
  end

  def enter_search_term(term)
    form = find("form[action='/search']")
    form.fill_in 'search_term', with: term
    form.find('#search-submit').click
  end

  def expect_page_to_have_product_details(product)
    expect(page).to have_content product.name
    expect(page).to have_content (product.price.round)
    expect(page).to have_content (product.short_description)
    expect(page).to have_css ("img[src$='#{product.image}']")
  end

  def expect_page_to_have_crystal_or_herb(object)
    expect(page).to have_content object.name
    expect(page).to have_css ("img[src$='#{object.image.big_thumb}']")
  end
end