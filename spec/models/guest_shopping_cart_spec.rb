require 'spec_helper'

describe GuestShoppingCart do

  let(:product) {Fabricate(:product)} 
  let(:shopping_cart_item) {GuestShoppingCart.new(sellable_id: product.id, sellable_type: 'Product', qty: 7)}

  it "response to sellable" do
    expect(shopping_cart_item.sellable).to eq(product)
  end

  it "response to sellable_id" do
    expect(shopping_cart_item.sellable_id).to eq(product.id)
  end

  it "response to qty" do
    expect(shopping_cart_item.qty).to eq(7)
  end

  it "response to name" do
    expect(shopping_cart_item.name).to eq(product.name)
  end

  it "response to id" do
    expect(shopping_cart_item.id).to eq(product.id)
  end

  it "response to price" do
    expect(shopping_cart_item.price).to eq(product.price)
  end

  it "response to total price" do
    expect(shopping_cart_item.total_price).to eq(7*shopping_cart_item.price)
  end

  it "response so price whene the sellable_type is essential oil" do
    essential_oil = Fabricate(:essential_oil)
    item =  GuestShoppingCart.new(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '5ml', qty: 7)
    expect(item.price).to eq(essential_oil.price_5ml)
    item =  GuestShoppingCart.new(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '10ml', qty: 7)
    expect(item.price).to eq(essential_oil.price_10ml)
    item =  GuestShoppingCart.new(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '50ml', qty: 7)
    expect(item.price).to eq(essential_oil.price_50ml)
  end

  describe "#params_validated?" do
    let(:product) {Fabricate(:product)} 
    let(:essential_oil) {Fabricate(:essential_oil)}

    it "return true for valid params" do
      expect(GuestShoppingCart.params_validated?(sellable_id: product.id, sellable_type: 'Product', qty: 4)).to eq(true)
    end
    
    it "return false for invalid qty" do
      expect(GuestShoppingCart.params_validated?(sellable_id: product.id, sellable_type: 'Product', qty: -4)).to eq(false)
    end

    it "return false for invalid sellable type" do
      expect(GuestShoppingCart.params_validated?(sellable_id: product.id, sellable_type: 'Products', qty: 4)).to eq(false)
    end

    it "return false for non invalid sellable_id" do
      expect(GuestShoppingCart.params_validated?(sellable_id: 3.4, sellable_type: 'Product', qty: 4)).to eq(nil)      
      expect(GuestShoppingCart.params_validated?(sellable_id: 5000, sellable_type: 'Product', qty: 4)).to eq(nil) 
    end  

    it "return true when sellable type is essential oil and package type is correct" do
      expect(GuestShoppingCart.params_validated?(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '5ml',qty: 4)).to eq(true)
      expect(GuestShoppingCart.params_validated?(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '10ml',qty: 4)).to eq(true)
      expect(GuestShoppingCart.params_validated?(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '50ml',qty: 4)).to eq(true)
    end

    it "return false when sellable type is essential oil and package type is not correct" do
      expect(GuestShoppingCart.params_validated?(sellable_id: essential_oil.id, sellable_type: 'EssentialOil',qty: 4)).to eq(false)
      expect(GuestShoppingCart.params_validated?(sellable_id: essential_oil.id, sellable_type: 'EssentialOil', package_type: '40ml',qty: 4)).to eq(false)
    end

  end

  describe "#qty_validated?" do
    it "return true for valid param" do
      expect(GuestShoppingCart.qty_validated?("7")).to eq(true)
    end

    it "return false for not valid param" do
      expect(GuestShoppingCart.qty_validated?("-7")).to eq(false)
      expect(GuestShoppingCart.qty_validated?("7.1")).to eq(false)
      expect(GuestShoppingCart.qty_validated?("maya")).to eq(false)
      expect(GuestShoppingCart.qty_validated?(nil)).to eq(false)
    end

  end

end