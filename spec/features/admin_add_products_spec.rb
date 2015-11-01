require 'spec_helper'

feature 'Admin Add Products' do

  given(:admin) {Fabricate(:admin)}

  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete products" do

    set_categories
    food = Category.find_by(name: 'מזון רפואי')

    tahini = Fabricate(:category, category_id: food.id)
    olives = Fabricate(:category, category_id: food.id)
    rosemary = Fabricate(:medicinal_herb)
    merkaba = Fabricate(:medicinal_herb)
    
    visit home_path
    # Add Products
    product1 = add_new_product(tahini, [rosemary.id])
    check_product_pages(product1, tahini, [rosemary.id])
    product2 = add_new_product(tahini, [rosemary.id, merkaba.id])
    check_product_pages(product2, tahini, [rosemary.id, merkaba.id])
    product3 = add_new_product(olives, [merkaba.id])
    check_product_pages(product3, olives, [merkaba.id])
    product4 = add_new_product(olives, [rosemary.id, merkaba.id])
    check_product_pages(product4, olives, [rosemary.id, merkaba.id])
    # Updates
    update_product_attribute(product1, 'name', 'Gold Flower Of Life')
    check_product_attribute_and_return_old_value(product1, 'name', 'Gold Flower Of Life')
 
    update_product_attribute(product1, 'english_name', 'tahini')
    check_product_attribute_and_return_old_value(product1, 'english_name', 'Tahini')

    update_product_attribute(product1, 'short_description', 'bla bla bla bla')
    check_product_attribute_and_return_old_value(product1, 'short_description', 'bla bla bla bla')

    update_product_attribute(product1, 'price', '20000')
    check_product_attribute_and_return_old_value(product1, 'price', 20000)
 
    update_product_attribute(product1, 'stock', '70')
    check_product_attribute_and_return_old_value(product1, 'stock', 70)

    update_product_attribute(product1, 'quantity', '7')
    check_product_attribute_and_return_old_value(product1, 'quantity', 7)

    update_product_attribute(product1, 'medium_package_price', '20')
    check_product_attribute_and_return_old_value(product1, 'medium_package_price', 20)

    update_product_attribute(product1, 'medium_package_quantity', '77')
    check_product_attribute_and_return_old_value(product1, 'medium_package_quantity', 77)

    update_product_attribute(product1, 'big_package_price', '22')
    check_product_attribute_and_return_old_value(product1, 'big_package_price', 22)

    update_product_attribute(product1, 'big_package_quantity', '776')
    check_product_attribute_and_return_old_value(product1, 'big_package_quantity', 776)

    update_product_attribute(product1, 'package_weight', '72')
    check_product_attribute_and_return_old_value(product1, 'package_weight', 72)

    update_product_attribute(product1, 'long_description', 'this is a very long description')
    check_product_attribute_and_return_old_value(product1, 'long_description', 'this is a very long description')

    update_product_attribute(product1, 'use_instructions', 'this is how you use the products')
    check_product_attribute_and_return_old_value(product1, 'use_instructions', 'this is how you use the products')

    update_product_attribute(product1, 'ingridience', 'ingridience list')
    check_product_attribute_and_return_old_value(product1, 'ingridience', 'ingridience list')

    update_product_attribute(product1, 'use_instructions', 'this is how you use the products')
    check_product_attribute_and_return_old_value(product1, 'use_instructions', 'this is how you use the products')

    update_product_attribute(product1, 'warnings', 'very very (NOT) dangerous')
    check_product_attribute_and_return_old_value(product1, 'warnings', 'very very (NOT) dangerous')
 
    update_product_attribute(product1, 'price', '20000')
    check_product_attribute_and_return_old_value(product1, 'price', 20000)
 
    update_product_attribute(product1, 'stock', '70')
    check_product_attribute_and_return_old_value(product1, 'stock', 70)

    test_product_category_update(product1, olives)
    test_product_medicinal_herbs_update(product1, [merkaba.id])
    test_product_image_update(product1)
    test_product_quantity_unit_update(product1)
    test_product_nutritional_data_update(product1)
    # Delete
    #delete_product(product1)
    #expect(Product.count).to eq(3)

    # Stock Update
    test_product_image_update(product3)
    test_update_stock(product3)
  end

  def add_new_product(category, medicinal_herb_ids)
    product_attr = Fabricate.attributes_for(:product, category: category, medicinal_herbs_ids: medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    click_link 'הוסף מוצר חדש לאתר'

    fill_in 'product_name', with: product_attr[:name]
    fill_in 'product_english_name', with: product_attr[:english_name]
    select category.name , from: 'product_category_id' 
    attach_file "*תמונה:", "spec/support/uploads/product.jpg"
  
    fill_in 'product_price', with: product_attr[:price]  
    fill_in 'product_quantity', with: product_attr[:quantity]
    select product_attr[:quantity_unit] , from: 'product_quantity_unit' 
    fill_in 'product_stock', with: product_attr[:stock]  
    fill_in 'product_package_weight', with: product_attr[:package_weight]

    fill_in 'product_short_description', with: product_attr[:short_description]
    fill_in 'product_long_description', with: product_attr[:long_description]
    fill_in 'product_use_instructions', with: product_attr[:use_instructions]
    fill_in 'product_ingridience', with: product_attr[:ingridience]
    fill_in 'product_warnings', with: product_attr[:warnings]

    medicinal_herb_ids.each do |id|
      check "product_medicinal_herb_ids_#{id}" 
    end
    
    page.find('#product-form-submit').click
    return Product.last
  end

  def check_product_pages(product, category, medicinal_herbs_ids)
    #Check Category Page
    main_menu = page.find('.store-main-menu')
    main_menu.click_link category.name
    expect(page).to have_content product.name
    expect(page).to have_content (product.price.round)
    expect(page).to have_content (product.short_description)
    expect(page).to have_css ("img[src$='#{product.image}']")
    #Check Medicinal Herbs pages
    medicinal_herbs_ids.each do |id| 
      info_main_menu = page.find('.info-main-menu') 
      info_main_menu.click_link 'לפי שם הצמח' 
      click_link MedicinalHerb.find(id).name
      expect(page).to have_content product.name
      expect(page).to have_content (product.price.round)
      expect(page).to have_css ("img[src$='#{product.image}']")
    end
    #Check Product Page
    click_link product.name
    product_info = page.find('.product-info')
    tabs = page.find('.tabs-panel')
    expect(product_info).to have_content product.name
    expect(product_info).to have_content (product.price.round)
    expect(product_info).to have_css ("img[src$='#{product.image}']")
    expect(product_info).to have_content product.short_description
    expect(tabs).to have_content product.long_description
    expect(tabs).to have_content product.ingridience
    expect(tabs).to have_content product.use_instructions
    expect(tabs).to have_content product.warnings
    expect(tabs).to_not have_content 'ערך תזונתי'
  end

  def update_product_attribute(product, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}/edit']").click
    fill_in "product_#{attribute}", with: value
    page.find('#product-form-submit').click
  end

  def check_product_attribute_and_return_old_value(product, attribute, value)
    product_from_db = Product.find(product.id)
    expect(product_from_db.name).to eq(product.name) unless attribute == 'name'
    expect(product_from_db.english_name).to eq(product.english_name) unless attribute == 'english_name'
    expect(product_from_db.short_description).to eq(product.short_description) unless attribute == 'short_description'
    expect(product_from_db.price).to eq(product.price) unless attribute == 'price'   
    expect(product_from_db.stock).to eq(product.stock) unless attribute == 'stock'
    expect(product_from_db.category_id).to eq(product.category_id) unless attribute == 'category_id'
    expect(product_from_db.medicinal_herb_ids).to eq(product.medicinal_herb_ids) unless attribute == 'medicinal_herb_ids'    
    expect(product_from_db.long_description).to eq(product.long_description) unless attribute == 'long_description'   
    expect(product_from_db.use_instructions).to eq(product.use_instructions) unless attribute == 'use_instructions'
    expect(product_from_db.ingridience).to eq(product.ingridience) unless attribute == 'ingridience'   
    expect(product_from_db.warnings).to eq(product.warnings) unless attribute == 'warnings'
    expect(product_from_db.quantity).to eq(product.quantity) unless attribute == 'quantity'   
    expect(product_from_db.quantity_unit).to eq(product.quantity_unit) unless attribute == 'quantity_unit'
    expect(product_from_db.package_weight).to eq(product.package_weight) unless attribute == 'package_weight'
    expect(product_from_db.medium_package_price).to eq(product.medium_package_price) unless attribute == 'medium_package_price' 
    expect(product_from_db.medium_package_quantity).to eq(product.medium_package_quantity) unless attribute == 'medium_package_quantity'
    expect(product_from_db.big_package_price).to eq(product.big_package_price) unless attribute == 'big_package_price' 
    expect(product_from_db.big_package_quantity).to eq(product.big_package_quantity) unless attribute == 'big_package_quantity'

    if attribute
      expect(product_from_db[attribute.to_sym]).to eq(value)
      product_from_db.update_attribute(attribute.to_sym, product[attribute.to_sym])
    end
  end

  def  test_product_category_update(product, category)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}/edit']").click
    select category.name , from: 'product_category_id' 
    page.find('#product-form-submit').click
    check_product_attribute_and_return_old_value(product, "category_id", category.id)
  end
   
  def test_product_medicinal_herbs_update(product, medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}/edit']").click
    product.medicinal_herb_ids.each do |id|
      uncheck "product_medicinal_herb_ids_#{id}" 
    end 
    medicinal_herb_ids.each do |id|
      check "product_medicinal_herb_ids_#{id}" 
    end     
    page.find('#product-form-submit').click
    
    expect(Product.find(product.id).medicinal_herb_ids).to eq(medicinal_herb_ids)
    product.update(medicinal_herb_ids: product.medicinal_herb_ids)
  end
  
  def test_product_image_update(product)
    expect(product.reload.image.url).to eq("/uploads/product.jpg")
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link 'מוצרים'
    find("a[href='/admin/products/#{product.slug}/edit']").click
    attach_file "*תמונה:", "spec/support/uploads/new_pic.jpg"
    page.find('#product-form-submit').click
    expect(Product.find(product.id).image.url).to eq("/uploads/new_pic.jpg")

  end 

  def  test_product_quantity_unit_update(product)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}/edit']").click
    select 'מ"ל' , from: 'product_quantity_unit' 
    page.find('#product-form-submit').click
    check_product_attribute_and_return_old_value(product, 'quantity_unit', 'מ"ל')
  end

  def test_product_nutritional_data_update(product)
    expect(product.is_food?).to eq(false)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}/edit']").click
    fill_in 'product_energy', with: '12'
    fill_in 'product_carbohydrates', with: '13'
    fill_in 'product_protein', with: '14'
    fill_in 'product_fat', with: '15'
    fill_in 'product_saturated_fat', with: '16'
    fill_in 'product_cholesterol', with: '17'
    fill_in 'product_sodium', with: '18.23'
    fill_in 'product_other_nutrients', with: 'list of nutrients'
    page.find('#product-form-submit').click
    main_menu = page.find('.store-main-menu')
    main_menu.click_link product.category.name
    click_link product.name
    product_info = page.find('.product-info')
    tabs = page.find('.tabs-panel')
    expect(tabs).to have_content 'ערך תזונתי'
    expect(tabs).to have_content 'אנרגיה 12 קק"ל, חלבון 14 גרם, פחמימות 13 גרם, שומן 15 גרם, מתוכו שומן רווי 16 גרם, כולסטרול 17 גרם, נתרן 18.23 גרם'
    expect(tabs).to have_content 'list of nutrients'
  end

  def delete_product(product)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "מוצרים"
    find("a[href='/admin/products/#{product.slug}']").click
  end

  def test_update_stock(product)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "ניהול מלאי"
    form = find("form[action='/admin/products/#{product.slug}/stock']")
    expect(form.find_field('stock').value).to  eq(product.stock.to_s)
    form.fill_in 'stock', with: 7
    #require pry; binding.pry
    form.find('#product-stock-submit').click
    menu.click_link "ניהול מלאי"
    form = find("form[action='/admin/products/#{product.slug}/stock']")  
    expect(product.reload.stock).to eq(7)
    expect(form.find_field('stock').value).to  eq('7')
  end

end