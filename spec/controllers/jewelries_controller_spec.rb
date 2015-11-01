require 'spec_helper'

describe JewelriesController do
  describe 'GET show' do
    context "jewelry with crystal" do 
      let!(:crystal) {Fabricate(:crystal)}
      let!(:jewelry) { Fabricate(:jewelry, crystal_id: crystal.id) }
      let!(:jewelry_crystal) { Fabricate(:jewelry_crystal, jewelry: jewelry, crystal: crystal)}
      before {
        get :show, id: jewelry.slug
      }

      it "set @jewelry" do      
        expect(assigns(:jewelry)).to be_instance_of(Jewelry)
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

    context "jewelry without crystal" do

      let!(:jewelry) { Fabricate(:jewelry, crystal_id: nil) }

      before {
        get :show, id: jewelry.slug
      }

      it "set @jewelry" do      
        expect(assigns(:jewelry)).to be_instance_of(Jewelry)
      end

      it "set @crystal id" do
        expect(assigns(:crystal_id)).to eq(nil)
      end

      it "set @price" do
        expect(assigns(:price)).to eq(jewelry.price)
      end

      it "set @sellable_type" do
        expect(assigns(:sellable_type)).to eq('Jewelry')
      end

      it "set @sellable_id" do
        expect(assigns(:sellable_id)).to eq(jewelry.id)
      end
    end 
  end

  describe 'GET index' do

    it "set @jewelries" do  
      get :index
      expect(assigns(:jewelries)).to eq([])
    end
  end

end