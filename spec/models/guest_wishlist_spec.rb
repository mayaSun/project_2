require 'spec_helper'

describe GuestShoppingCart do

  let(:product) {Fabricate(:product)} 
  let(:shopping_cart_item) {GuestWishlist.new(product_id: product.id)}

  it "response to product_id" do
    expect(shopping_cart_item.product_id).to eq(product.id)
  end

  it "response to product" do
    expect(shopping_cart_item.product).to eq(product)
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

end