require 'spec_helper'

describe JewelryCrystal do 

  it {should validate_presence_of(:jewelry)}
  it {should validate_presence_of(:crystal)}
  it {should belong_to(:jewelry)}
  it {should belong_to(:crystal)}

  it {should validate_numericality_of(:price)}

  it {should have_many(:shopping_cart_items)}
  it {should have_many(:wishlist_items)}

  describe "#orders" do
    it "return the orders contained the jewelry_crystal" do
      jewelry_crystal = Fabricate(:jewelry_crystal)
      other_jewelry_crystal = Fabricate(:jewelry_crystal)
      order1 = ShoppingCartItem.create(sellable: jewelry_crystal, position: Fabricate(:order), qty: 1)
      order2 = ShoppingCartItem.create(sellable: other_jewelry_crystal, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: jewelry_crystal, position: Fabricate(:order), qty: 1)
      expect(jewelry_crystal.orders.count).to eq(2)
      expect(jewelry_crystal.orders).to include(order1)
      expect(jewelry_crystal.orders).to include(order3)
      expect(jewelry_crystal.orders).to_not include(order2)
    end

    it "return [] if there is no orders" do
      jewelry_crystal = Fabricate(:jewelry_crystal)
      other_jewelry_crystal = Fabricate(:jewelry_crystal)
      ShoppingCartItem.create(sellable: other_jewelry_crystal, position: Fabricate(:order), qty: 1)
      expect(jewelry_crystal.orders).to eq([])
    end
  end

  describe "#last_ordered" do
    it "return the last order date of the jewelry_crystal" do
      jewelry_crystal = Fabricate(:jewelry_crystal)
      other_jewelry_crystal = Fabricate(:jewelry_crystal)
      order1 = ShoppingCartItem.create(sellable: jewelry_crystal, position: Fabricate(:order), qty: 1, updated_at: 1.days.ago)
      order2 = ShoppingCartItem.create(sellable: other_jewelry_crystal, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: jewelry_crystal, position: Fabricate(:order), qty: 1, updated_at: 3.days.ago)
      expect(jewelry_crystal.last_ordered.to_formatted_s(:short) ).to eq(order1.updated_at.to_formatted_s(:short))
    end
  end

end