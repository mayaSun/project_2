require 'spec_helper'

feature 'Admin Add recipe' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete recipe" do

    set_categories
    visit home_path
    # Add recipes
    recipe_1 = add_new_recipe()
    check_recipe_pages(recipe_1)
    recipe_2 = add_new_recipe()
    check_recipe_pages(recipe_2)
    recipe_3 = add_new_recipe()
    check_recipe_pages(recipe_3)
    # Update recipe
    update_recipe_attribute(recipe_1, 'title', 'maya recipe_1')
    check_recipe_attribute_and_return_old_value(recipe_1, 'title', 'maya recipe_1')
    update_recipe_attribute(recipe_2, 'text', 'best silver ever')
    check_recipe_attribute_and_return_old_value(recipe_2, 'text', 'best silver ever')
    test_recipe_image_update(recipe_3)
    # Delete recipe
    #delete_recipe(recipe_1)
  end

  def add_new_recipe
    recipe_attr = Fabricate.attributes_for(:recipe)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מרשמים עתיקים"
    click_link 'הוסף מרשם חדש לאתר'
    fill_in '*כותרת:', with: recipe_attr[:title]
    fill_in "*טקסט:", with: recipe_attr[:text]
    attach_file "תמונה:", "spec/support/uploads/product.jpg"
    page.find('#recipe-form-submit').click
    return Recipe.last
  end

  def check_recipe_pages(recipe)
    #expect(page).to have_content recipe.text
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'מרשמים עתיקים'
    expect(page).to have_content recipe.title
  end

def update_recipe_attribute(recipe, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מרשמים עתיקים"
    find("a[href='/admin/recipes/#{recipe.slug}/edit']").click
    fill_in "recipe_#{attribute}", with: value
    page.find('#recipe-form-submit').click
  end

  def check_recipe_attribute_and_return_old_value(recipe, attribute, value)
    recipe_from_db = Recipe.find(recipe.id)
    expect(recipe_from_db.title).to eq(recipe.title) unless attribute == 'title'
    expect(recipe_from_db.text).to eq(recipe.text) unless attribute == 'text'
    if attribute
      expect(recipe_from_db[attribute.to_sym]).to eq(value)
      recipe_from_db.update_attribute(attribute.to_sym, recipe[attribute.to_sym])
    end
  end

  def  test_recipe_sub_recipe_update(recipe, parent_recipe)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מרשמים עתיקים"
    find("a[href='/admin/recipes/#{recipe.slug}/edit']").click
    select parent_recipe.title , from: "סוג מוצר:" 
    page.find('#recipe-form-submit').click
    check_recipe_attribute_and_return_old_value(recipe, "recipe_id", parent_recipe.id)
  end

  
  def test_recipe_image_update(recipe)
    expect(recipe.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מרשמים עתיקים"
    find("a[href='/admin/recipes/#{recipe.slug}/edit']").click
    attach_file "תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#recipe-form-submit').click
    expect(Recipe.find(recipe.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_recipe(recipe)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מרשמים עתיקים"
    find("a[href='/admin/recipes/#{recipe.slug}'][data-method='delete']").click
  end

end