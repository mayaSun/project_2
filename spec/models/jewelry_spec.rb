require 'spec_helper'

describe Jewelry do 

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:english_name)}

  it {should validate_numericality_of(:price)}

  it {should have_many(:jewelry_crystals)}
  it {should have_many(:crystals)}
  it {should have_many(:shopping_cart_items)}
  it {should have_many(:wishlist_items)}

  describe "#orders" do
    it "return the orders contained the jewelry" do
      jewelry = Fabricate(:jewelry)
      other_jewelry = Fabricate(:jewelry)
      order1 = ShoppingCartItem.create(sellable: jewelry, position: Fabricate(:order), qty: 1)
      order2 = ShoppingCartItem.create(sellable: other_jewelry, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: jewelry, position: Fabricate(:order), qty: 1)
      expect(jewelry.orders.count).to eq(2)
      expect(jewelry.orders).to include(order1)
      expect(jewelry.orders).to include(order3)
      expect(jewelry.orders).to_not include(order2)
    end

    it "return [] if there is no orders" do
      jewelry = Fabricate(:jewelry)
      other_jewelry = Fabricate(:jewelry)
      ShoppingCartItem.create(sellable: other_jewelry, position: Fabricate(:order), qty: 1)
      expect(jewelry.orders).to eq([])
    end
  end

  describe "#last_ordered" do
    it "return the last order date of the jewelry" do
      jewelry = Fabricate(:jewelry)
      other_jewelry = Fabricate(:jewelry)
      order1 = ShoppingCartItem.create(sellable: jewelry, position: Fabricate(:order), qty: 1, updated_at: 1.days.ago)
      order2 = ShoppingCartItem.create(sellable: other_jewelry, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: jewelry, position: Fabricate(:order), qty: 1, updated_at: 3.days.ago)
      expect(jewelry.last_ordered.to_formatted_s(:short) ).to eq(order1.updated_at.to_formatted_s(:short))
    end
  end

  describe "#validate_jewelry_crystals_data" do
    let(:jewelry)  { Fabricate(:jewelry) }
    it "return true for valid params" do
      params = {
        "0"=>{price:"100", crystal_id:"4"},
        "1"=>{price:"200", crystal_id:"7"},
        "2"=>{price:"20", crystal_id:"8"},
        "3"=>{price:"20", crystal_id:"9"},
        "4"=>{price:"20", crystal_id:"10"},
        "5"=>{price:"20", crystal_id:"11"},
        "6"=>{price:"20", crystal_id:"12"},
        "7"=>{price:"111", crystal_id:"6"},
        "8"=>{price:"1", crystal_id:"13"},
        "9"=>{price:"2", crystal_id:"14"},
        "10"=>{price:"2000", crystal_id:"15"},
        "11"=>{price:"20", crystal_id:"16"},
        "12"=>{price:"20", crystal_id:"17"},
        "13"=>{price:"20", crystal_id:"18"},
        "14"=>{price:"", crystal_id:""},
        "15"=>{price:"", crystal_id:""},
        "16"=>{price:"", crystal_id:""},
        "17"=>{price:"", crystal_id:""},
        "18"=>{price:"", crystal_id:""}}
        expect(jewelry.validate_jewelry_crystals_data(params)).to eq(true)
    end

    it "return true for empty params" do
      params = {
        "0"=>{price:"100", crystal_id:""},
        "1"=>{price:"200", crystal_id:""},
        "2"=>{price:"20", crystal_id:""},
        "3"=>{price:"20", crystal_id:""},
        "4"=>{price:"20", crystal_id:""}}
        expect(jewelry.validate_jewelry_crystals_data(params)).to eq(true)
    end

    it "return error for multiple crystal" do
      params = {
        "0"=>{price:"100", crystal_id:"13"},
        "1"=>{price:"200", crystal_id:"7"},
        "2"=>{price:"20", crystal_id:"8"},
        "3"=>{price:"20", crystal_id:"9"},
        "4"=>{price:"20", crystal_id:"10"},
        "5"=>{price:"20", crystal_id:"11"},
        "6"=>{price:"20", crystal_id:"12"},
        "7"=>{price:"111", crystal_id:"6"},
        "8"=>{price:"1", crystal_id:"13"},
        "9"=>{price:"2", crystal_id:"14"},
        "10"=>{price:"2000", crystal_id:"15"},
        "11"=>{price:"20", crystal_id:"16"},
        "12"=>{price:"20", crystal_id:"17"},
        "13"=>{price:"20", crystal_id:"18"},
        "14"=>{price:"", crystal_id:""},
        "15"=>{price:"", crystal_id:""},
        "16"=>{price:"", crystal_id:""},
        "17"=>{price:"", crystal_id:""},
        "18"=>{price:"", crystal_id:""}}
        expect(jewelry.validate_jewelry_crystals_data(params)).to eq('The same crystal can not be added more then once')
    end
    it "return error for bad price" do
      params = {
        "0"=>{price:"100", crystal_id:"4"},
        "1"=>{price:"200", crystal_id:"7"},
        "2"=>{price:"20", crystal_id:"8"},
        "3"=>{price:"20", crystal_id:"9"},
        "4"=>{price:"20", crystal_id:"10"},
        "5"=>{price:"20", crystal_id:"11"},
        "6"=>{price:"20", crystal_id:"12"},
        "7"=>{price:"111", crystal_id:"6"},
        "8"=>{price:"1", crystal_id:"13"},
        "9"=>{price:"", crystal_id:"14"},
        "10"=>{price:"2000", crystal_id:"15"},
        "11"=>{price:"20", crystal_id:"16"},
        "12"=>{price:"20", crystal_id:"17"},
        "13"=>{price:"20", crystal_id:"18"},
        "14"=>{price:"", crystal_id:""},
        "15"=>{price:"", crystal_id:""},
        "16"=>{price:"", crystal_id:""},
        "17"=>{price:"", crystal_id:""},
        "18"=>{price:"", crystal_id:""}}
        expect(jewelry.validate_jewelry_crystals_data(params)).to eq('Price must be positive number')
    end
  end

  describe "#set_jewelry_crystals_data" do
    let!(:jewelry) {Fabricate(:jewelry)}
    let!(:crystal1) {Fabricate(:crystal)}
    let!(:crystal2) {Fabricate(:crystal)}
    let!(:crystal3) {Fabricate(:crystal)}
    let!(:crystal4) {Fabricate(:crystal)}
    let!(:crystal5) {Fabricate(:crystal)}
    let!(:crystal6) {Fabricate(:crystal)}
    let!(:crystal7) {Fabricate(:crystal)}

    it "set all jewelry crystals crystals for new record" do
      params = {
        "0"=>{price:"100", crystal_id: crystal4.id.to_s},
        "1"=>{price:"200", crystal_id: crystal5.id.to_s},
        "2"=>{price:"20", crystal_id: crystal6.id.to_s},
        "3"=>{price:"20", crystal_id: crystal1.id.to_s},
        "4"=>{price:"20", crystal_id: crystal2.id.to_s},
        "5"=>{price:"20", crystal_id: crystal3.id.to_s},
        "6"=>{price:"20", crystal_id: crystal7.id.to_s},
        "7"=>{price:"", crystal_id:""},
        "8"=>{price:"", crystal_id:""},
        "9"=>{price:"", crystal_id:""}}
      jewelry.set_jewelry_crystals_data(params)
      expect(jewelry.jewelry_crystals.map{ |x| x[:price]}).to eq([100, 200, 20, 20, 20, 20, 20])  
      expect(jewelry.jewelry_crystals.map{ |x| x[:crystal_id]}).to eq([crystal4.id, crystal5.id, crystal6.id, crystal1.id, crystal2.id, crystal3.id, crystal7.id])  
    end

    it "update the data of exist jewelry crystal" do
      jewelry.jewelry_crystals.create(crystal_id: crystal4.id, price: 100)
      jewelry.jewelry_crystals.create(crystal_id: crystal5.id, price: 40)
      jewelry.jewelry_crystals.create(crystal_id: crystal7.id, price: 20)
      params = {
        "0"=>{price:"100", crystal_id: crystal4.id.to_s},
        "1"=>{price:"200", crystal_id: crystal5.id.to_s},
        "2"=>{price:"20", crystal_id: crystal6.id.to_s},
        "3"=>{price:"20", crystal_id: crystal1.id.to_s},
        "4"=>{price:"20", crystal_id: crystal2.id.to_s},
        "5"=>{price:"20", crystal_id: crystal3.id.to_s},
        "6"=>{price:"20", crystal_id: crystal7.id.to_s},
        "7"=>{price:"", crystal_id:""},
        "8"=>{price:"", crystal_id:""},
        "9"=>{price:"", crystal_id:""}} 
      jewelry.set_jewelry_crystals_data(params)  
      expect(jewelry.jewelry_crystals.map{ |x| x[:price]}).to eq([100, 200, 20, 20, 20, 20, 20])  
      expect(jewelry.jewelry_crystals.map{ |x| x[:crystal_id]}).to eq([crystal4.id, crystal5.id, crystal6.id, crystal1.id, crystal2.id, crystal3.id, crystal7.id])  
    end

    it "delete data" do
      jewelry.jewelry_crystals.create(crystal_id: crystal4.id, price: 100)
      jewelry.jewelry_crystals.create(crystal_id: crystal5.id, price: 40)
      jewelry.jewelry_crystals.create(crystal_id: crystal7.id, price: 20)
      params = {
        "0"=>{price:"100", crystal_id: crystal4.id.to_s},
        "1"=>{price:"200", crystal_id: crystal5.id.to_s},
        "2"=>{price:"20", crystal_id: "מחק"},
        "3"=>{price:"", crystal_id:""},
        "4"=>{price:"", crystal_id:""},
        "5"=>{price:"", crystal_id:""}} 
      jewelry.set_jewelry_crystals_data(params)  
      expect(jewelry.reload.jewelry_crystals.map{ |x| x[:price]}).to eq([100, 200])  
      expect(jewelry.jewelry_crystals.map{ |x| x[:crystal_id]}).to eq([crystal4.id, crystal5.id])  
    end       

    it "set the crystal Id data" do
      new_jewelry = Fabricate(:jewelry, crystal_id: crystal1.id)
            params = {
          "0"=>{price:"100", crystal_id: crystal4.id.to_s},
          "1"=>{price:"200", crystal_id: crystal5.id.to_s},
          "2"=>{price:"20", crystal_id: crystal6.id.to_s},
          "3"=>{price:"20", crystal_id: ""},
          "4"=>{price:"20", crystal_id: crystal2.id.to_s},
          "5"=>{price:"20", crystal_id: crystal3.id.to_s},
          "6"=>{price:"20", crystal_id: crystal7.id.to_s},
          "7"=>{price:"", crystal_id:""},
          "8"=>{price:"", crystal_id:""},
          "9"=>{price:"", crystal_id:""}}
        new_jewelry.set_jewelry_crystals_data(params)
        expect(new_jewelry.jewelry_crystals.map{ |x| x[:price]}).to eq([100, 200, 20, 20, 20, 20, new_jewelry.price])  
        expect(new_jewelry.jewelry_crystals.map{ |x| x[:crystal_id]}).to eq([crystal4.id, crystal5.id, crystal6.id, crystal2.id, crystal3.id, crystal7.id, crystal1.id])  
    end

  end

  describe "#jewelry_crystal" do
    
    it "return jewelry crystal" do
      jewelry = Fabricate(:jewelry)
      crystal = Fabricate(:crystal)
      jewelry_crystal = Fabricate(:jewelry_crystal, jewelry: jewelry, crystal: crystal)
      expect(jewelry.jewelry_crystal(crystal.id)).to eq(jewelry_crystal)
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:jewelry) }
  end

end