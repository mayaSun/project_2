require 'spec_helper'

describe JewelryCrystalsController do
  describe 'GET show' do

    let!(:crystal) {Fabricate(:crystal)}
    let!(:jewelry) { Fabricate(:jewelry, crystal_id: crystal.id) }
    let!(:jewelry_crystal) { Fabricate(:jewelry_crystal, jewelry: jewelry, crystal: crystal)}
    before {
      get :show, id: jewelry_crystal.slug
    }

    it "set @jewelry" do      
      expect(assigns(:jewelry)).to eq(jewelry)
    end

    it "set @crystal id" do
      expect(assigns(:crystal_id)).to eq(crystal.id)
    end

    it "set @price" do
      expect(assigns(:price)).to eq(jewelry_crystal.price)
    end

    it "set @sellable_type" do
      expect(assigns(:sellable_type)).to eq('JewelryCrystal')
    end

    it "set @sellable_id" do
      expect(assigns(:sellable_id)).to eq(jewelry_crystal.id)
    end
  end
end