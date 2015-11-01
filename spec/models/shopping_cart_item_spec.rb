require 'spec_helper'

describe ShoppingCartItem do
  it {should belong_to(:position)}
  it {should belong_to(:sellable)}
  it {should validate_presence_of(:sellable)}
  it {should validate_presence_of(:position)}
  it {should validate_numericality_of(:qty)}

  it {should respond_to(:name)}
  it {should respond_to(:english_name)}
  it {should respond_to(:image)}


  describe "#total_price" do
    it "return the total price for product" do
      product = Fabricate(:product)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: product)
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*product.price)
    end

    it "return the total price for jewelry" do
      jewelry = Fabricate(:jewelry)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: jewelry)
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*jewelry.price)
    end

    it "return the total price for jewelry_crystal" do
      jewelry = Fabricate(:jewelry_crystal)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: jewelry)
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*jewelry.price)
    end

    it "return the total price for essential_oil" do
      essential_oil = Fabricate(:essential_oil)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: essential_oil, package_type: '5ml')
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*essential_oil.price_5ml)
      shopping_cart_item.update(package_type: '10ml')
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*essential_oil.price_10ml)      
      shopping_cart_item.update(package_type: '50ml')
      expect(shopping_cart_item.total_price).to eq(shopping_cart_item.qty*essential_oil.price_50ml)      
    end    
  end

  describe "#check_essential_oil_package_type" do
    it "doese not create shopping_bag_item when essential oil package type not correct" do
      essential_oil = Fabricate(:essential_oil)
      shopping_cart_item = ShoppingCartItem.create(sellable: essential_oil, qty: 1,package_type: '2ml')   
      expect(ShoppingCartItem.count).to eq(0)
    end

    it "doese not create shopping_bag_item when essential oil package type is nil" do
      essential_oil = Fabricate(:essential_oil)
      shopping_cart_item = ShoppingCartItem.create(sellable: essential_oil)      
      expect(ShoppingCartItem.count).to eq(0)
    end

    it "create shopping_bag_item when essential oil package type is correct" do
      essential_oil = Fabricate(:essential_oil)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: essential_oil, package_type: '5ml')   
      expect(ShoppingCartItem.count).to eq(1)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: essential_oil, package_type: '10ml')   
      expect(ShoppingCartItem.count).to eq(2)
      shopping_cart_item = Fabricate(:shopping_cart_item, sellable: essential_oil, package_type: '50ml')   
      expect(ShoppingCartItem.count).to eq(3)
    end

  end
end