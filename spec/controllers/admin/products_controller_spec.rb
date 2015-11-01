require 'spec_helper'

describe Admin::ProductsController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @categories" do      
      get :index
      expect(assigns(:categories)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, product: Fabricate.attributes_for(:product)
      end

      it "create a product" do
        expect(Product.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_products_path
      end

    end

    context "with invalid input" do

      before do
        post :create, product: Fabricate.attributes_for(:product, name: nil)
      end

      it "dose not create product" do
        expect(Product.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @product" do
        expect(assigns(:product)).to be_instance_of(Product)
      end
    end
  end

  describe 'GET edit' do

    let(:product) {Fabricate(:product)}
    before {
      get :edit , id: product.slug
    }

    it "set the @product veriable" do        
      expect(assigns[:product]).to eq(product)
    end

  end

  describe 'PATCH update' do

    let(:product) { Fabricate(:product) }

    context "with valid input" do
      before {
        patch :update, id: product.slug ,product: {english_name: 'New name'}
      }

      it "update the product name" do
        expect(product.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_products_path
      end

    end

    context "with invalid input" do
      before {
        patch :update, id: product.slug, product: {name: nil}
      }

      it "does not update the product" do
        expect(Product.first.name).to eq(product.name)
      end

      it "set the @product veriable" do        
        expect(assigns[:product]).to eq(product)
      end

      it "render edit" do
        expect(response).to render_template :edit
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end
  end


  describe 'DELETE destroy' do

    let(:product) {Fabricate(:product)}
    before {
      delete :destroy, id: product.slug
    }

    it "delete the product" do
      expect(Product.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_products_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

  describe 'Get stock' do

    it "set the @products according to stock order" do
      product1 = Fabricate(:product, stock: 7)
      product2 = Fabricate(:product, stock: 70)
      get :stock
      expect(assigns[:products]).to eq([product1,product2])
    end

  end

  describe 'PATCH update_stock' do

    let(:product) { Fabricate(:product) }

    context "with valid input" do
      before {
        patch :update_stock, id: product.slug ,stock: 77
      }

      it "update the product stock" do
        expect(product.reload.stock).to eq(77)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "render index admin" do
        expect(response).to render_template :stock
      end

    end

    context "with invalid input" do

      before {
        patch :update_stock, id: product.slug ,stock: -7
      }

      it "does not update the product" do
        expect(Product.first.stock).to eq(product.stock)
      end

      it "set the @products veriable" do        
        expect(assigns[:products]).to eq([product])
      end

      it "render index admin" do
        expect(response).to render_template :stock
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

    end

  end


  describe 'DELETE destroy' do

    let(:product) {Fabricate(:product)}
    before {
      delete :destroy, id: product.slug
    }

    it "delete the product" do
      expect(Product.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_products_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::ProductsController do

  let(:product) {Fabricate(:product)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, product: Fabricate.attributes_for(:product)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: product.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: product.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: product.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :stock}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update_stock, id: product.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: product.slug}
  end

end