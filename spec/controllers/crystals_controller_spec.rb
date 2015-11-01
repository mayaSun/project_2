require 'spec_helper'

describe CrystalsController do
  
  describe 'GET show' do
    let(:crystal) { Fabricate(:crystal) }
    before {
      get :show, id: crystal.slug
    }

    it "set @crystal" do      
      expect(assigns(:crystal)).to be_instance_of(Crystal)
    end

  end

  describe 'GET index' do

    it "set @crystals" do  
      get :index    
      expect(assigns(:crystals)).to eq([])
    end

  end

end