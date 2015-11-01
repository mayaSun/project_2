require 'spec_helper'

describe MedicinalHerbsController do
  describe 'GET show' do

    let(:medicinal_herb) { Fabricate(:medicinal_herb) }
    before {
      get :show, id: medicinal_herb.slug
    }

    it "set @medicinal_herb" do      
      expect(assigns(:medicinal_herb)).to be_instance_of(MedicinalHerb)
    end

    it "set @products" do      
      expect(assigns(:products)).to eq([])
    end

  end

  describe 'GET index' do

    it "set @medicinal_herbs" do  
      get :index
      expect(assigns(:medicinal_herbs)).to eq([])
    end

  end


end