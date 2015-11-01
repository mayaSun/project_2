require 'spec_helper'

describe ShoppingCartItemsController do

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'GET index' do
    context "with user" do
      it "render index" do
        set_current_user()
        get :index
        expect(response).to render_template :index
      end
    end

    context "without user" do
      it "render index" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'POST create' do
    context "with user" do
      before do
        set_current_user()
      end
      context "with valid input" do
        before do
          post :create, sellable_id: Fabricate(:product).id, sellable_type: 'Product',  qty: 2
        end

        it "create a user Shopping Cart item" do
          expect(ShoppingCartItem.count).to eq(1)
        end

        it "create a user Shopping Cart item with the current_user" do
          expect(ShoppingCartItem.first.position).to eq(current_user)
        end

        it "set notice message" do
          expect(flash[:notice]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end
      end

      context "with invalid input" do

        before do
          post :create, sellable_id: Fabricate(:product).id, sellable_type: 'Product',  qty: 2.1
        end

        it "dose not create user Shopping Cart item" do
          expect(ShoppingCartItem.count).to eq(0)
        end

        it "set error message" do
          expect(flash[:error]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end
      end

      context "with essential oil package_type" do
        it "create shopping bag item with valid input" do
          post :create, sellable_id: Fabricate(:essential_oil).id, sellable_type: 'EssentialOil', "package_type#{EssentialOil.first.id}" => '10ml', qty: 2
          expect(ShoppingCartItem.count).to eq(1)
          expect(ShoppingCartItem.first.package_type).to eq('10ml')
        end
      end
    end

    context "without user" do
      
      context "with valid input" do
        let(:product) { Fabricate(:product)}
        before do
          post :create, sellable_id: product.id, sellable_type: 'Product',  qty: 2
        end

        it "does not create a user Shopping Cart item in the db" do
          expect(ShoppingCartItem.count).to eq(0)
        end

        it "create a user Shopping Cart item in the session veriable" do
          expect(session[:shopping_cart_item][0].to_i).to eq(product.id)
          expect(session[:shopping_cart_item_type][0]).to eq('Product')
          expect(session[:shopping_cart_item_qty][0].to_i).to eq(2)
          expect(session[:shopping_cart_item_package_type][0]).to eq(nil)
        end

        it "set notice message" do
          expect(flash[:notice]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end
      end

      context "with invalid input" do

        before do
          post :create, sellable_id: Fabricate(:product).id, sellable_type: 'Product',  qty: -2
        end

        it "dose not create user Shopping Cart item in the session" do
          expect(session[:shopping_cart_item].size).to eq(0)
          expect(session[:shopping_cart_item_qty].size).to eq(0)
          expect(session[:shopping_cart_item_type].size).to eq(0)
          expect(session[:shopping_cart_item_package_type].size).to eq(0)
        end

        it "set error message" do
          expect(flash[:error]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end
      end

      context "with essential oil package_type" do
        it "create shopping bag item with valid input" do
          essential_oil = Fabricate(:essential_oil)
          post :create, sellable_id: essential_oil.id, sellable_type: 'EssentialOil', "package_type#{EssentialOil.first.id}" => '10ml', qty: 2
          
          expect(session[:shopping_cart_item][0].to_i).to eq(essential_oil.id)
          expect(session[:shopping_cart_item_type][0]).to eq('EssentialOil')
          expect(session[:shopping_cart_item_qty][0].to_i).to eq(2)
          expect(session[:shopping_cart_item_package_type][0]).to eq('10ml')
        end
      end

      context "with all ready exist item" do
        let(:product) { Fabricate(:product)}
        before do
          session[:shopping_cart_item] = []
          session[:shopping_cart_item_type] = []
          session[:shopping_cart_item_qty] = []
          session[:shopping_cart_item_package_type] = []
          session[:shopping_cart_item][0] = product.id.to_s
          session[:shopping_cart_item_qty][0] = 2.to_s
          session[:shopping_cart_item_type][0] = 'Product'
          post :create, sellable_id: product.id, sellable_type: 'Product',  qty: 2
        end

        it "does not update settion veriable" do
          expect(session[:shopping_cart_item].size).to eq(1)
          expect(session[:shopping_cart_item_qty].size).to eq(1)
          expect(session[:shopping_cart_item_type].size).to eq(1)
        end

        it "set error message" do
          expect(flash[:error]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end

      end

    end
  end

  describe 'PATCH update' do

    context "with user" do

      let(:user) { Fabricate(:user) }
      let(:shopping_cart_item) { Fabricate(:shopping_cart_item, position: user) }
      before do
        set_current_user(user)
      end

      context "with valid input" do
        before {
          patch :update, id: shopping_cart_item.id ,qty: 7
        }

        it "update the shopping cart item qty" do
          expect(shopping_cart_item.reload.qty).to eq(7)
        end

        it "set notice message" do
          expect(flash[:notice]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end

      end

      context "with invalid input" do

        before {
          patch :update, id: shopping_cart_item.id ,qty: -7
        }

        it "does not update the user shopping cart item" do
          expect(ShoppingCartItem.first.qty).to eq(shopping_cart_item.qty)
        end

        it "set error message" do
          expect(flash[:error]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end

      end
    end

    context "without user" do

      let(:product) {Fabricate(:product)}
 
      before do
      session[:shopping_cart_item] = []
      session[:shopping_cart_item_type] = []
      session[:shopping_cart_item_qty] = []
      session[:shopping_cart_item_package_type] = []
      session[:shopping_cart_item][0] = product.id.to_s
      session[:shopping_cart_item_qty][0] = 2.to_s
      session[:shopping_cart_item_type][0] = 'Product'
      end

      context "with valid input" do
        before {
          patch :update, id: product.id , sellable_type: 'Product' ,qty: 7
        }

        it "update the shopping cart item qty" do
          expect(session[:shopping_cart_item_qty][0].to_i).to eq(7)
        end

        it "set notice message" do
          expect(flash[:notice]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end

      end

      context "with invalid input" do

        before {
          patch :update, id: product.id, sellable_type: 'Product' ,qty: -7
        }

        it "does not update the user shopping cart item" do
          expect(session[:shopping_cart_item_qty][0].to_i).to eq(2)
        end

        it "set error message" do
          expect(flash[:error]).to be_present
        end

        it "redirects back to the referring page" do
          expect(response).to redirect_to "where_i_came_from"
        end

      end

    end

  end


  describe 'DELETE destroy' do

    context "with user" do
      let(:shopping_cart_item) {Fabricate(:shopping_cart_item)}
      before {
        set_current_user()
        delete :destroy, id: shopping_cart_item.id
      }

      it "delete the user Shopping Cart items" do
        expect(ShoppingCartItem.count).to eq(0)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirects back to the referring page" do
        expect(response).to redirect_to "where_i_came_from"
      end
    end

    context "without user" do

      let(:product) {Fabricate(:product)}
 
      before do
        session[:shopping_cart_item] = []
        session[:shopping_cart_item_type] = []
        session[:shopping_cart_item_qty] = []
        session[:shopping_cart_item_package_type] = []
        session[:shopping_cart_item][0] = product.id.to_s
        session[:shopping_cart_item_qty][0] = 2.to_s
        session[:shopping_cart_item_type][0] = 'Product'
        delete :destroy, id: product.id, sellable_type: 'Product'
      end

      it "delete the user Shopping Cart items" do
        expect(session[:shopping_cart_item].size).to eq(0)
        expect(session[:shopping_cart_item_qty].size).to eq(0)
        expect(session[:shopping_cart_item_type].size).to eq(0)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirects back to the referring page" do
        expect(response).to redirect_to "where_i_came_from"
      end

    end

  end

end