require 'spec_helper'

feature 'Admin Add Active Ingredient' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete active ingredient" do
        
    set_categories
    
    rosmary = Fabricate(:medicinal_herb)
    mint = Fabricate(:medicinal_herb)

    visit home_path
    # Add Active Ingredient
    turpentine = add_new_active_ingredient([rosmary.id])
    check_active_ingredient_pages(turpentine, [rosmary.id])
    mayain = add_new_active_ingredient([rosmary.id, mint.id])
    check_active_ingredient_pages(mayain, [rosmary.id, mint.id])
    wax = add_new_active_ingredient([])
    check_active_ingredient_pages(wax,[])
    # Updates
    update_active_ingredient_attribute(turpentine, 'name', 'new name')
    check_active_ingredient_attribute_and_return_old_value(turpentine, 'name', 'new name')
 
    update_active_ingredient_attribute(turpentine, 'english_name', 'tahini')
    check_active_ingredient_attribute_and_return_old_value(turpentine, 'english_name', 'Tahini')

    update_active_ingredient_attribute(turpentine, 'description', 'bla bla bla bla')
    check_active_ingredient_attribute_and_return_old_value(turpentine, 'description', 'bla bla bla bla')

    test_active_ingredient_medicinal_herb_update(turpentine, [mint.id])

    # Delete
    expect(ActiveIngredient.count).to eq(3)
    #delete_active_ingredient(turpentine)
    #expect(ActiveIngredient.count).to eq(2)
  end

  def add_new_active_ingredient(medicinal_herb_ids)
    active_ingredient_attr = Fabricate.attributes_for(:active_ingredient, medicinal_herb_ids: medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'חומרים פעילים'
    click_link 'הוסף חומר פעיל לאתר'
    fill_in 'active_ingredient_name', with: active_ingredient_attr[:name]
    fill_in 'active_ingredient_english_name', with: active_ingredient_attr[:english_name]
    fill_in 'active_ingredient_description', with: active_ingredient_attr[:description]
    medicinal_herb_ids.each do |id|
      check "active_ingredient_medicinal_herb_ids_#{id}" 
    end
    page.find('#active_ingredient-form-submit').click
    return ActiveIngredient.last
  end

  def check_active_ingredient_pages(active_ingredient, medicinal_herb_ids)
    #Check Category Page
    main_menu = page.find('.info-main-menu')
    main_menu.click_link 'לפי חומרים פעילים'
    click_link active_ingredient.name
    expect(page).to have_content active_ingredient.name
    expect(page).to have_content (active_ingredient.description)
    medicinal_herb_ids.each do |id|
      medicinal_herb =  MedicinalHerb.find(id)
      expect(page).to have_content medicinal_herb.name
      expect(page).to have_css ("img[src$='#{medicinal_herb.image}']")
    end
  end

  def update_active_ingredient_attribute(active_ingredient, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "חומרים פעילים"
    find("a[href='/admin/active_ingredients/#{active_ingredient.slug}/edit']").click
    fill_in "active_ingredient_#{attribute}", with: value
    page.find('#active_ingredient-form-submit').click
  end

  def check_active_ingredient_attribute_and_return_old_value(active_ingredient, attribute, value)
    active_ingredient_from_db = ActiveIngredient.find(active_ingredient.id)
    expect(active_ingredient_from_db.name).to eq(active_ingredient.name) unless attribute == 'name'
    expect(active_ingredient_from_db.english_name).to eq(active_ingredient.english_name) unless attribute == 'english_name'
    expect(active_ingredient_from_db.description).to eq(active_ingredient.description) unless attribute == 'description'
    expect(active_ingredient_from_db.medicinal_herb_ids).to eq(active_ingredient.medicinal_herb_ids) unless attribute == 'medicinal_herb_ids'        
    if attribute
      expect(active_ingredient_from_db[attribute.to_sym]).to eq(value)
      active_ingredient_from_db.update_attribute(attribute.to_sym, active_ingredient[attribute.to_sym])
    end
  end

    def test_active_ingredient_medicinal_herb_update(active_ingredient, medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "חומרים פעילים"
    find("a[href='/admin/active_ingredients/#{active_ingredient.slug}/edit']").click
    active_ingredient.medicinal_herb_ids.each do |id|
      uncheck "active_ingredient_medicinal_herb_ids_#{id}" 
    end 
    medicinal_herb_ids.each do |id|
      check "active_ingredient_medicinal_herb_ids_#{id}" 
    end 
    page.find('#active_ingredient-form-submit').click
    expect(ActiveIngredient.find(active_ingredient.id).medicinal_herb_ids).to eq(medicinal_herb_ids)
    active_ingredient.update(medicinal_herb_ids: active_ingredient.medicinal_herb_ids)
  end
  
  def delete_active_ingredient(active_ingredient)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "חומרים פעילים"
    find("a[href='/admin/active_ingredients/#{active_ingredient.slug}']").click
  end

end