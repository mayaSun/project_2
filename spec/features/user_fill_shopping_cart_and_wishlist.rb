require 'spec_helper'

feature 'User Fill Shopping Cart And Wishlist' do

  given(:rosemary) { Fabricate(:medicinal_herb) }
  given(:lemon_grass) { Fabricate(:medicinal_herb) }
  
  given(:medicinal_food) { Fabricate(:category) }
  given(:tincture) { Fabricate(:category) }

  # Product
  given!(:green_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id]) }
  given!(:gold_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id]) }  
  given!(:gold_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [rosemary.id]) }  
  given!(:gold_lemon_grass) { Fabricate(:product, category: tincture, medicinal_herb_ids: [lemon_grass.id]) }  
  given!(:blue_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id], stock: 50, price: 100)}
  given!(:green_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id], stock: 50, price: 100) }  
  given!(:green_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [rosemary.id]) }  
  given!(:blue_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [lemon_grass.id]) } 
  given!(:blue_gold_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id]) }
  given!(:blue_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id]) }  
  given!(:red_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id]) }
  given!(:red_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id]) }  
  given!(:red_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [rosemary.id]) }  
  given!(:yellow_lemon_grass) { Fabricate(:product, category: tincture, medicinal_herb_ids: [lemon_grass.id]) }  
  given!(:tincture_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id]) }
  given!(:yellow_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id]) }  
  given!(:yellow_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [rosemary.id]) }  
  given!(:tincture_rosemary) { Fabricate(:product, category: tincture, medicinal_herb_ids: [lemon_grass.id]) } 
  given!(:tincture_gold_lemon_grass) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id]) }
  given!(:tincture_lemon_grass_rosemary) { Fabricate(:product, category: medicinal_food, medicinal_herb_ids: [lemon_grass.id, rosemary.id]) }  
 
  # Jewelry
  given!(:ruby) { Fabricate(:crystal) }
  given!(:diamond) { Fabricate(:crystal) }
  given!(:cat_eye) { Fabricate(:crystal) }

  given!(:necklace) { Fabricate(:jewelry, crystal_id: ruby.id) }
  given!(:ring) { Fabricate(:jewelry, crystal_id: diamond.id) }
  given!(:bracelet) {Fabricate(:jewelry, crystal_id: nil)}

  given!(:necklace_ruby) {Fabricate(:jewelry_crystal, jewelry: necklace, crystal: ruby)}
  given!(:necklace_diamond) {Fabricate(:jewelry_crystal, jewelry: necklace, crystal: diamond)}
  given!(:necklace_cat_eye) {Fabricate(:jewelry_crystal, jewelry: necklace, crystal: cat_eye)}

  given!(:ring_ruby) {Fabricate(:jewelry_crystal, jewelry: ring, crystal: ruby)}
  given!(:ring_diamond) {Fabricate(:jewelry_crystal, jewelry: ring, crystal: diamond)}
  given!(:ring_cat_eye) {Fabricate(:jewelry_crystal, jewelry: ring, crystal: cat_eye)}

  given!(:lavender) {Fabricate(:essential_oil, name: 'Lavender')}
  given!(:tee_tree) {Fabricate(:essential_oil, name: 'Tee Tree')}

  scenario "guest user fill shopping cart and wishlist" do
    set_categories
    user_adds_products_to_shopping_cart
  end

  scenario "user fill shopping cart and wishlist" do
    set_categories
    user = Fabricate(:user)
    page.set_rack_session(user_id: user.id)
    user_adds_products_to_shopping_cart
  end

  def user_adds_products_to_shopping_cart 
    # Category page
    visit home_path
    click_link medicinal_food.name
    expect_to_see_category_products(medicinal_food)
    add_product_from_list_to_shopping_cart(tincture_gold_lemon_grass)
    #add_product_from_list_to_wishlist(tincture_lemon_grass_rosemary)
    add_product_from_list_to_shopping_cart(yellow_lemon_grass_rosemary, 8)
    expect_product_to_be_in_shopping_cart(tincture_gold_lemon_grass)
    #expect_product_to_be_in_wishlist(tincture_lemon_grass_rosemary)
    expect_product_to_be_in_shopping_cart(yellow_lemon_grass_rosemary, 8)
    
    # Medicinal Herb page
    click_link 'לפי שם הצמח'
    click_link lemon_grass.name
    expect_to_see_medicinal_herb_products(lemon_grass)
    add_product_from_list_to_shopping_cart(red_lemon_grass_rosemary)
    #add_product_from_list_to_wishlist(yellow_lemon_grass)
    expect_product_to_be_in_shopping_cart(red_lemon_grass_rosemary)
    #expect_product_to_be_in_wishlist(yellow_lemon_grass) 
    
    # Product Page
    click_link 'לפי שם הצמח'
    click_link lemon_grass.name
    add_product_from_product_page_to_shopping_cart(blue_gold_lemon_grass)
    expect_product_to_be_in_shopping_cart(blue_gold_lemon_grass)

    click_link 'לפי שם הצמח'
    click_link lemon_grass.name
    add_product_from_product_page_to_shopping_cart(blue_lemon_grass, 7)
    expect_product_to_be_in_shopping_cart(blue_lemon_grass, 7)
    
    click_link 'לפי שם הצמח'
    click_link rosemary.name
    #add_product_from_product_page_to_wishlist(yellow_lemon_grass_rosemary)
    #expect_product_to_be_in_wishlist(yellow_lemon_grass_rosemary)
    
    # Jewelries 
    click_link 'תכשיטים רפואיים'
    click_link necklace.name
    add_jewelry_to_shopping_cart(necklace, ruby, 7)
    expect_jewelry_to_be_in_shopping_cart(necklace, ruby, 7)
    update_qty_of_shopping_cart_product(necklace, 6)
    expect_jewelry_to_be_in_shopping_cart(necklace, ruby, 6)
    click_link 'תכשיטים רפואיים'
    find('.product-info-box').click_link necklace.name
    add_jewelry_to_shopping_cart(necklace, diamond, 2)
    expect_jewelry_to_be_in_shopping_cart(necklace, diamond, 2)
    click_link 'תכשיטים רפואיים'
    find('.product-info-box').click_link bracelet.name
    add_jewelry_to_shopping_cart(bracelet, nil, 1)
    expect_jewelry_to_be_in_shopping_cart(bracelet, nil, 1)

    #Essential Oils
    click_link 'שמנים אתריים'
    add_essential_oil_to_shopping_cart(lavender, 7)
    expect_essential_oil_to_be_in_shopping_cart(lavender, 7)
    update_qty_of_shopping_cart_product(lavender, 6)
    expect_essential_oil_to_be_in_shopping_cart(lavender, 6)
    click_link 'שמנים אתריים'
    find('.product-info-box').click_link tee_tree.name
    add_essential_oil_to_shopping_cart(tee_tree, 7)
    expect_essential_oil_to_be_in_shopping_cart(tee_tree, 7)

    # Wishlist
    #add_product_from_wishlist_to_shopping_cart(yellow_lemon_grass_rosemary)
    #expect_product_to_be_in_shopping_cart(yellow_lemon_grass_rosemary)
    #expect_product_not_to_be_in_wishlist(yellow_lemon_grass_rosemary)
    
    #delete_product_from_wishlist(yellow_lemon_grass)
    #expect_product_not_to_be_in_shopping_cart(yellow_lemon_grass)
    #expect_product_not_to_be_in_wishlist(yellow_lemon_grass)
  
    # Shopping Cart
    find('.dropdown-toggle-shopping-cart').click
    click_link "ראה סל קניות"
    update_qty_of_shopping_cart_product(tincture_gold_lemon_grass, 8)
    expect_product_to_be_in_shopping_cart(tincture_gold_lemon_grass, 8)
    update_qty_of_shopping_cart_product(lavender, 10)
    delete_product_from_shopping_cart(tincture_gold_lemon_grass)
    expect_product_not_to_be_in_shopping_cart(tincture_gold_lemon_grass)

    # Summary
    validate_shopping_cart_and_wishlist_summary
  
  end

  def validate_shopping_cart_and_wishlist_summary
    #expect_product_to_be_in_shopping_cart(green_lemon_grass, 8)
    expect_product_to_be_in_shopping_cart(red_lemon_grass_rosemary)
    expect_product_to_be_in_shopping_cart(blue_gold_lemon_grass)
    expect_product_to_be_in_shopping_cart(blue_lemon_grass, 7)
    expect_product_to_be_in_shopping_cart(yellow_lemon_grass_rosemary, 8)

    #expect_product_to_be_in_wishlist(tincture_lemon_grass)
    #expect_product_to_be_in_wishlist(tincture_lemon_grass_rosemary) 
  end

  def add_product_from_list_to_shopping_cart(product, qty=1)
    form = find("#add-product-#{product.id}")
    form.fill_in 'qty', with: qty
    form.find('.btn-cart').click
  end

  def add_product_from_list_to_wishlist(product)
    find("a[href='/wishlist_items?product_id=#{product.id}']").click
  end

  def expect_product_to_be_in_shopping_cart(product, qty=1)
    click_link "ראה סל קניות"
    shopping_cart = find('.shopping-cart-table')
    tr = shopping_cart.find('tr', text: product.name)
    expect(tr).to have_content product.name
    expect(tr).to have_content (product.price.round)
    expect(tr.find_field('qty').value).to eq (qty.to_s)
    expect(tr).to have_content (product.price.round*qty%1000) # fixme %1000 - because the price come in this format xxx,xxx,xxx
  end

  def add_jewelry_to_shopping_cart(jewelry, crystal=nil, qty=1)
    if crystal && crystal.id != jewelry.crystal_id
      click_link "אותו התכשיט עם #{crystal.name}"
    end
    form = find("#add-jewelry-#{jewelry.id}")
    form.fill_in 'qty', with: qty
    form.find('.btn-cart').click  
  end

  def expect_jewelry_to_be_in_shopping_cart(jewelry, crystal=nil, qty=1)
    price = (crystal != nil) ? jewelry.jewelry_crystal(crystal).price.round  : jewelry.price.round
    click_link "ראה סל קניות"
    shopping_cart = find('.shopping-cart-table')
    tr = shopping_cart.find('tr', text: price.to_s)
    expect(tr).to have_content jewelry.name
    expect(tr).to have_content (price)
    expect(tr.find_field('qty').value).to eq (qty.to_s)
    expect(tr).to have_content (price*qty%1000) # fixme %1000 - because the price come in this format xxx,xxx,xxx    
  end

  def add_essential_oil_to_shopping_cart(essential_oil, qty=1)
    form = find("#add-essential-oil-#{essential_oil.id}")
    form.fill_in 'qty', with: qty
    form.find('.btn-cart').click
  end

  def expect_essential_oil_to_be_in_shopping_cart(essential_oil, qty=7)
    click_link "ראה סל קניות"
    shopping_cart = find('.shopping-cart-table')
    tr = shopping_cart.find('tr', text: essential_oil.name)
    expect(tr).to have_content essential_oil.name
    expect(tr).to have_content (essential_oil.price_5ml.round)
    expect(tr.find_field('qty').value).to eq (qty.to_s)
    expect(tr).to have_content (essential_oil.price_5ml.round*qty%1000) # fixme %1000 - because the price come in this format xxx,xxx,xxx    
  end

  def expect_product_to_be_in_wishlist(product)
    find("a[href='/wishlist']").click
    wishlist = find('.shopping-cart-table')
    expect(wishlist).to have_content product.name
    expect(wishlist).to have_content (product.price.round)
  end

  def add_product_from_product_page_to_shopping_cart(product, qty=1)
    find(:xpath, "(//a[@href='/products/#{product.slug}'])[1]").click
    form = find('.product-info')
    form.fill_in "qty", with: qty
    form.click_button("הוסף לסל")
  end

  def add_product_from_product_page_to_wishlist(product)
    find(:xpath, "(//a[@href='/products/#{product.slug}'])[1]").click
    form = find('.product-info')
    form.find('.btn-wishlist').click
  end  

  def expect_to_see_category_products(category)
    category.products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_content (product.price.round)
      expect(page).to have_css ("img[src$='#{product.image}']") 
    end
  end

  def expect_to_see_medicinal_herb_products(medicinal_herb)
    medicinal_herb.products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_content (product.price.round)
      expect(page).to have_css ("img[src$='#{product.image}']") 
    end
  end

  def add_product_from_wishlist_to_shopping_cart(product)
    find("a[href='/wishlist']").click
    tr = find('tr', text: product.name)
    tr.click_link("הוסף לסל")
  end

  def expect_product_not_to_be_in_wishlist(product)
    find("a[href='/wishlist']").click
    wishlist = find('.shopping-cart-table')
    expect(wishlist).to_not have_content product.name
  end

  def  delete_product_from_wishlist(product)
    find("a[href='/wishlist']").click
    tr = find('tr', text: product.name)
    tr.find('.btn-warning').click
  end

  def expect_product_not_to_be_in_shopping_cart(product)
    click_link "ראה סל קניות"
    expect(page).to_not have_content product.name
  end

  def update_qty_of_shopping_cart_product(product, qty)
    shopping_cart = find('.shopping-cart-table')
    tr = shopping_cart.find('tr', text: product.name)
    tr.fill_in "qty", with: qty
    tr.find('.btn-update').click
  end

  def delete_product_from_shopping_cart(product)
    shopping_cart = find('.shopping-cart-table')
    tr = shopping_cart.find('tr', text: product.name)
    tr.find('.btn-warning').click
  end

end