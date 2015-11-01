require 'spec_helper'

describe EssentialOil do 

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:english_name)}

  it {should validate_numericality_of(:price_5ml)}
  it {should validate_numericality_of(:price_10ml)}
  it {should validate_numericality_of(:price_50ml)}

  it {should have_many(:shopping_cart_items)}
  it {should have_many(:wishlist_items)}

  describe "search essential_oil by name" do

    let(:mayami) { Fabricate(:essential_oil, name: "Mayami")}
    let(:kalidaso) { Fabricate(:essential_oil,english_name: "Kalidaso")}

    it "return array of  all the essential_oil with a given name" do
      expect(EssentialOil.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the essential_oils with a partial match" do
      expect(EssentialOil.search_by_name("a")).to include(mayami)
      expect(EssentialOil.search_by_name("a")).to include(kalidaso)
      expect(EssentialOil.search_by_name("a").size).to eq(2)
    end

    it "return empty string when dosn't find essential_oils with given name" do
      expect(EssentialOil.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(EssentialOil.search_by_name("")).to eq([])
    end
  end

  describe "#orders" do
    it "return the orders contained the essential_oil" do
      essential_oil = Fabricate(:essential_oil)
      other_essential_oil = Fabricate(:essential_oil)
      order1 = ShoppingCartItem.create(sellable: essential_oil, package_type: '5ml', position: Fabricate(:order), qty: 1)
      order2 = ShoppingCartItem.create(sellable: other_essential_oil,package_type: '10ml', position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: essential_oil, package_type: '10ml',position: Fabricate(:order), qty: 1)
      expect(essential_oil.orders.count).to eq(2)
      expect(essential_oil.orders).to include(order1)
      expect(essential_oil.orders).to include(order3)
      expect(essential_oil.orders).to_not include(order2)
    end

    it "return [] if there is no orders" do
      essential_oil = Fabricate(:essential_oil)
      other_essential_oil = Fabricate(:essential_oil)
      ShoppingCartItem.create(sellable: other_essential_oil, position: Fabricate(:order), qty: 1)
      expect(essential_oil.orders).to eq([])
    end
  end

  describe "#last_ordered" do
    it "return the last order date of the essential_oil" do
      essential_oil = Fabricate(:essential_oil)
      other_essential_oil = Fabricate(:essential_oil)
      order1 = ShoppingCartItem.create(sellable: essential_oil, package_type: '5ml', position: Fabricate(:order), qty: 1, updated_at: 1.days.ago)
      order2 = ShoppingCartItem.create(sellable: other_essential_oil, package_type: '50ml', position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: essential_oil, package_type: '10ml', position: Fabricate(:order), qty: 1, updated_at: 3.days.ago)
      expect(essential_oil.last_ordered.to_formatted_s(:short) ).to eq(order1.updated_at.to_formatted_s(:short))
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:essential_oil) }
  end

end