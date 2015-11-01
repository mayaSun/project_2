require 'spec_helper'

describe PagesController do
  describe 'GET home' do
    it "set new_products" do
      get :home
      expect(assigns(:new_products)).to eq([])
    end
    it "set best sellers" do
      get :home
      expect(assigns(:best_sellers)).to eq([])
    end
  end

  describe 'GET search' do
    it "set products" do
      get :search
      expect(assigns(:products)).to eq([])
    end

    it "set crystals" do
      get :search
      expect(assigns(:crystals)).to eq([])
    end

    it "set medicinal herbs" do
      get :search
      expect(assigns(:medicinal_herbs)).to eq([])
    end

    it "set medical activities" do
      get :search
      expect(assigns(:medical_activities)).to eq([])
    end

    it "set active ingredient" do
      get :search
      expect(assigns(:active_ingredients)).to eq([])
    end        
  end

  describe 'GET seed_bank' do

    it "set @medical_activities" do  
      get :seed_bank
      expect(assigns(:medicinal_herbs_1)).to eq([])
      expect(assigns(:medicinal_herbs_2)).to eq([])
      expect(assigns(:medicinal_herbs_3)).to eq([])
      expect(assigns(:medicinal_herbs_4)).to eq([])
    end

    it "devide the medical activities well for 4% => 0 numbers" do
      herb2 = Fabricate(:medicinal_herb, name: 'ממריץ')
      herb1 = Fabricate(:medicinal_herb, name: 'מחזק')
      herb3 = Fabricate(:medicinal_herb, name: 'משלשל')
      herb4 = Fabricate(:medicinal_herb, name: 'מתלתל')
      get :seed_bank
      expect(assigns(:medicinal_herbs_1)).to eq([herb1])
      expect(assigns(:medicinal_herbs_2)).to eq([herb2])
      expect(assigns(:medicinal_herbs_3)).to eq([herb3])
      expect(assigns(:medicinal_herbs_4)).to eq([herb4])
    end

    it "devide the medical activities well for 4% => 1 numbers" do      
      herb3 = Fabricate(:medicinal_herb, name: 'ממריץ')
      herb2 = Fabricate(:medicinal_herb, name: 'מחזק')
      herb4 = Fabricate(:medicinal_herb, name: 'משלשל')
      herb1 = Fabricate(:medicinal_herb, name: 'אנטי ויראלי')
      herb5 = Fabricate(:medicinal_herb, name: 'מתלתל')
      get :seed_bank
      expect(assigns(:medicinal_herbs_1)).to eq([herb1, herb2])
      expect(assigns(:medicinal_herbs_2)).to eq([herb3])
      expect(assigns(:medicinal_herbs_3)).to eq([herb4])
      expect(assigns(:medicinal_herbs_4)).to eq([herb5])
    end

  end

end