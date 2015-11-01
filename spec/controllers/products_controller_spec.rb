require 'spec_helper'

describe ProductsController do
  describe 'GET show' do
    let(:product) { Fabricate(:product) }
    before {
      get :show, id: product.slug
    }

    it "set @categories" do      
      expect(assigns(:product)).to be_instance_of(Product)
    end

    it "set @related_products" do      
      expect(assigns(:related_products)).to eq([])
    end
  end

  describe 'GET index' do

    it "set @products" do  
      get :index
      expect(assigns(:products)).to eq([])
    end
  end

end