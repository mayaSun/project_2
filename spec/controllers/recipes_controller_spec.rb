require 'spec_helper'

describe RecipesController do

  describe 'GET index' do

    it "set @recipes" do  
      get :index
      expect(assigns(:recipes)).to eq([])
    end
  end

end