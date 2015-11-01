require 'spec_helper'

describe EssentialOilsController do
  describe 'GET show' do
    let(:essential_oil) { Fabricate(:essential_oil) }
    let!(:other_essential_oil) { Fabricate(:essential_oil) }
    before {
      get :show, id: essential_oil.slug
    }

    it "set @essential_oil" do      
      expect(assigns(:essential_oil)).to be_instance_of(EssentialOil)
    end

    it "set @essential_oils" do      
      expect(assigns(:essential_oils)).to eq([other_essential_oil])
    end
  end

  describe 'GET index' do

    it "set @essential_oils" do  
      get :index
      expect(assigns(:essential_oils)).to eq([])
    end
  end

end