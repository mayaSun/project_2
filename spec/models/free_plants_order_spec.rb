require 'spec_helper'

describe FreePlantsOrder do 

  it {should validate_presence_of(:delivery_method)}
  it {should validate_presence_of(:address)}
  it {should belong_to(:address)}

  describe "#validates_uniquness_of_email" do

    it "return true for mail that does not exist in the data base" do
      order = Fabricate(:free_plants_order) 
      FreePlantsOrder.create(Fabricate.attributes_for(:free_plants_order))
      expect(FreePlantsOrder.count).to eq(2)
    end

    it "return false for mail that exist in the data base" do
      address1 = Fabricate(:address, email: 'love@me.com')
      address2 = Fabricate(:address, email: 'love@me.com')
      order = Fabricate(:free_plants_order, address: address1) 
      FreePlantsOrder.create(Fabricate.attributes_for(:free_plants_order, address: address2))
      expect(FreePlantsOrder.count).to eq(1)
    end

  end

end