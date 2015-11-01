require 'spec_helper'

feature 'Admin Add Category' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete category" do

    set_categories
    visit home_path
    # Add Categories
    tahini = add_new_category()
    check_category_pages(tahini)
    olives = add_new_category()
    check_category_pages(olives)
    black_cumin = add_new_category()
    check_category_pages(black_cumin)
    # Update Category
    update_category_attribute(tahini, 'english_name', 'maya tahini')
    check_category_attribute_and_return_old_value(tahini, 'english_name', 'Maya Tahini')
    update_category_attribute(olives, 'description', 'best silver ever')
    check_category_attribute_and_return_old_value(olives, 'description', 'best silver ever')
    test_category_sub_category_update(tahini, Category.find(1))
    test_category_image_update(black_cumin)
    # Delete Category
    delete_category(tahini)
    expect(Category.count).to eq(6)   
    product = Fabricate(:product, category: olives)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'קטגוריות'
    expect(page).to have_content product.name
  end

  def add_new_category
    category_attr = Fabricate.attributes_for(:category)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קטגוריות"
    click_link 'הוסף קטגוריה חדשה לאתר'
    fill_in 'שם:', with: category_attr[:name]
    fill_in 'שם באנגלית:', with: category_attr[:english_name]
    fill_in "תיאור:", with: category_attr[:description]
    select 'מזון רפואי' , from: 'category_category_id' 
    attach_file "תמונה:", "spec/support/uploads/product.jpg"
    page.find('#category-form-submit').click
    return Category.last
  end

  def check_category_pages(category)
    main_menu = page.find('.store-main-menu')
    main_menu.click_link category.name
    expect(page).to have_content category.name
    #expect(page).to have_content category.description
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'קטגוריות'
    expect(page).to have_content category.name
  end

def update_category_attribute(category, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קטגוריות"
    find("a[href='/admin/categories/#{category.slug}/edit']").click
    fill_in "category_#{attribute}", with: value
    page.find('#category-form-submit').click
  end

  def check_category_attribute_and_return_old_value(category, attribute, value)
    category_from_db = Category.find(category.id)
    expect(category_from_db.name).to eq(category.name) unless attribute == 'name'
    expect(category_from_db.description).to eq(category.description) unless attribute == 'description'
    if attribute
      expect(category_from_db[attribute.to_sym]).to eq(value)
      category_from_db.update_attribute(attribute.to_sym, category[attribute.to_sym])
    end
  end

  def  test_category_sub_category_update(category, parent_category)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קטגוריות"
    find("a[href='/admin/categories/#{category.slug}/edit']").click
    select parent_category.name , from: "סוג מוצר:" 
    page.find('#category-form-submit').click
    check_category_attribute_and_return_old_value(category, "category_id", parent_category.id)
  end

  
  def test_category_image_update(category)
    expect(category.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קטגוריות"
    find("a[href='/admin/categories/#{category.slug}/edit']").click
    attach_file "תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#category-form-submit').click
    expect(Category.find(category.id).image.url).to eq("/uploads/new_pic.jpg")
  end 

  def delete_category(category)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "קטגוריות"
    find("a[href='/admin/categories/#{category.slug}'][data-method='delete']").click
  end

end