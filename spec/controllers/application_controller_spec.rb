require 'spec_helper'

describe ApplicationController do

  describe "#set_session_verables" do
    it "set session veriable if not set yet" do
      subject.set_session_verables
      expect(session[:shopping_cart_item]).to eq([])
      expect(session[:shopping_cart_item_qty]).to eq([])
      expect(session[:shopping_cart_item_type]).to eq([])
      expect(session[:shopping_cart_item_package_type]).to eq([])
    end

    it "not set session veriable if set" do
      session[:shopping_cart_item] = ['1']
      session[:shopping_cart_item_type] = ['EssentialOil']
      session[:shopping_cart_item_qty] = ['3']
      session[:shopping_cart_item_package_type] = ['10ml']
      subject.set_session_verables
      expect(session[:shopping_cart_item]).to eq(['1'])
      expect(session[:shopping_cart_item_qty]).to eq(['3'])
      expect(session[:shopping_cart_item_type]).to eq(['EssentialOil'])
      expect(session[:shopping_cart_item_package_type]).to eq(['10ml'])
    end

    context 'with  order_id' do

      let(:order) { Fabricate(:order, status: ["Paid","Pending"].sample) }

      before do
        session[:shopping_cart_item] = []
        session[:shopping_cart_item_type] = []
        session[:shopping_cart_item_qty] = []
        session[:shopping_cart_item_package_type] = []
        session[:wishlist_item] = []
      end

      context "with user" do
        let!(:user) {Fabricate(:user)}
        let!(:shopping_cart_item) { Fabricate(:shopping_cart_item, position: user) }
        let!(:shopping_cart_item2) { Fabricate(:shopping_cart_item, position: user) }

        before do
          set_current_user(user)
          session[:order_id] = order.id
          subject.set_session_verables    
        end

        it "set to nil session order_id" do
          expect(session[:order_id]).to eq(nil)
        end

        it "set to delete user shopping cart" do
          expect(ShoppingCartItem.count).to eq(0)
        end

      end

      context "without user" do

        let(:product) { Fabricate(:product) }
        let(:product2) { Fabricate(:product) }
        
        before do
          session[:shopping_cart_item] = []
          session[:shopping_cart_item_type] = []
          session[:shopping_cart_item_qty] = []
          session[:shopping_cart_item_package_type] = []
          session[:shopping_cart_item][0] = product.id.to_s
          session[:shopping_cart_item_qty][0] = 2.to_s
          session[:shopping_cart_item_type] = 'Product'
          session[:shopping_cart_item][0] = product2.id.to_s
          session[:shopping_cart_item_qty][0] = 3.to_s
          session[:shopping_cart_item_type] = 'Product'
          session[:order_id] = order.id
          subject.set_session_verables
        end

        it "set to nil session order_id" do
          expect(session[:order_id]).to eq(nil)
        end

        it "set to nil session shopping cart" do
          expect(session[:shopping_cart_item]).to eq([])
          expect(session[:shopping_cart_item_type]).to eq([])
          expect(session[:shopping_cart_item_package_type]).to eq([])
          expect(session[:shopping_cart_item_qty]).to eq([])
        end
      end
    end

  end

  describe "#current_user" do
    it "return current user if exist" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      expect(subject.current_user).to eq(user)
    end

    it "return nil if user not exist" do
      session[:user_id] = nil
      expect(subject.current_user).to eq(nil)
    end
  end

  describe "#logged_in?" do
    it "return true" do
      set_current_user()
      expect(subject.logged_in?).to eq(true)
    end
    
    it "return false" do
      expect(subject.logged_in?).to eq(false)
    end
  end

  describe "#current_user_admin?" do
    it "return true" do
      set_current_user(Fabricate(:admin))
      expect(subject.current_user_admin?).to eq(true)
    end
    
    it "return true for shop_woner" do
      set_current_user(Fabricate(:user, role: 'shop_owner'))
      expect(subject.current_user_admin?).to eq(true)
    end

    it "return false" do
      set_current_user()
      expect(subject.current_user_admin?).to eq(false)
    end
  end

  describe "#shopping_cart" do
    context "with user" do
      let!(:user) { Fabricate(:user) }
      let!(:item1) { Fabricate(:shopping_cart_item, position: user) } 
      let!(:item2) { Fabricate(:shopping_cart_item, position: user) }
      
      before do
        set_current_user(user)
      end
      
      it "set the shopping cart with the right size" do
        expect(subject.shopping_cart.count).to eq(2)
      end

      it "include all uset shopping cart items" do
        expect(subject.shopping_cart).to include(item1)
        expect(subject.shopping_cart).to include(item2)
      end
    end

    context "without user" do

      let(:product1) { Fabricate(:product)}
      let(:product2) { Fabricate(:product)}
      before do
        session[:shopping_cart_item] = [product1.id.to_s, product2.id.to_s]
        session[:shopping_cart_item_type] = ['Product','Product']
        session[:shopping_cart_item_qty] = ['7','4'] 
        session[:shopping_cart_item_package_type] = [] 
      end
      
      it "set the shopping cart with the right size" do
        expect(subject.shopping_cart.count).to eq(2)
      end

      it "include all uset shopping cart items" do
        expect(subject.shopping_cart.map(&:sellable_id)).to include(product1.id)
        expect(subject.shopping_cart.map(&:sellable_id)).to include(product2.id)
        expect(subject.shopping_cart.map(&:sellable_type)).to eq(['Product','Product'])
        expect(subject.shopping_cart.map(&:price)).to include(product1.price)
        expect(subject.shopping_cart.map(&:price)).to include(product2.price)
      end
    end

    it "return [] if shopping cart is empty" do
      subject.set_session_verables
      expect(subject.shopping_cart).to eq([])
      set_current_user()
      expect(subject.shopping_cart).to eq([])
    end

  end

  describe "#total_bill" do
    context "with user" do
      let(:product1) { Fabricate(:product)}
      let(:product2) { Fabricate(:product)}
      let!(:user) { Fabricate(:user) }
      let!(:item1) { Fabricate(:shopping_cart_item, position: user, sellable: product1) } 
      let!(:item2) { Fabricate(:shopping_cart_item, position: user, sellable: product2) }
      
      before do
        set_current_user(user)
      end
      
      it "return total bill" do
        expect(subject.total_bill).to eq(product1.price * item1.qty + product2.price * item2.qty)
      end
    end

    context "without user" do

      let(:product1) { Fabricate(:product)}
      let(:product2) { Fabricate(:product)}
      before do
        session[:shopping_cart_item] = [product1.id.to_s, product2.id.to_s]
        session[:shopping_cart_item_type] = ['Product','Product']
        session[:shopping_cart_item_qty] = ['7','4'] 
        session[:shopping_cart_item_package_type] = [] 
      end
      
      it "return total bill" do
        expect(subject.total_bill).to eq(product1.price * 7 + product2.price * 4)
      end
    end

    it "return zero if shopping cart is empty" do
      subject.set_session_verables
      expect(subject.total_bill).to eq(0)
      set_current_user()
      expect(subject.total_bill).to eq(0)
    end
  end

  describe "#set_shopping_items"  do

    let(:product1) { Fabricate(:product) }
    let(:product2) { Fabricate(:product) }
    let(:user) { Fabricate(:user) }

    before do
      session[:shopping_cart_item] = [product1.id.to_s, product2.id.to_s]
      session[:shopping_cart_item_type] = ['Product','Product']
      session[:shopping_cart_item_qty] = ['7','4'] 
      session[:shopping_cart_item_package_type] = [] 
      session[:wishlist_item] = []
    end  

    it "set shopping cart items" do
      subject.set_shopping_items(user)
      expect(ShoppingCartItem.count).to eq(2)
      expect(ShoppingCartItem.all.map(&:sellable_id)).to include(product1.id)
      expect(ShoppingCartItem.all.map(&:sellable_id)).to include(product2.id)
      expect(ShoppingCartItem.all.map(&:sellable_type)).to eq(['Product','Product'])      
      expect(ShoppingCartItem.all.map(&:position)).to eq([user,user]) 
    end

    it "clear session veriable" do
      session[:shopping_cart_item] = []
      session[:shopping_cart_item_type] = []
      session[:shopping_cart_item_qty] = [] 
      session[:shopping_cart_item_package_type] = [] 
      session[:wishlist_item] = []
    end

    it "does not set shopping cart item if cart is empty" do
      session[:shopping_cart_item] = []
      session[:shopping_cart_item_type] = []
      session[:shopping_cart_item_qty] = [] 
      session[:shopping_cart_item_package_type] = [] 
      session[:wishlist_item] = []  
      subject.set_shopping_items(user)
      expect(ShoppingCartItem.count).to eq(0)      
    end
  end

  describe "#shopping_cart_item_index" do
    let(:product) { Fabricate(:product) }
    let(:essential_oil) { Fabricate(:essential_oil) }
    let(:jewelry) { Fabricate(:jewelry)}

    before do
      session[:shopping_cart_item] = [product.id.to_s, essential_oil.id.to_s, jewelry.id.to_s, 7]
      session[:shopping_cart_item_type] = ['Product','EssentialOil','jewelry', 'Jewelry']
      session[:shopping_cart_item_qty] = ['7','4','2', '1'] 
      session[:shopping_cart_item_package_type] = [nil, '50ml', nil, nil] 
      session[:wishlist_item] = []
    end  

    it "return the index of existing item" do
      expect(subject.shopping_cart_item_index('Product', product.id.to_s)).to eq(0)
      expect(subject.shopping_cart_item_index('EssentialOil', essential_oil.id.to_s)).to eq(1)
      expect(subject.shopping_cart_item_index('jewelry', jewelry.id.to_s)).to eq(2)
    end

    it "return nil for non exist item" do
      expect(subject.shopping_cart_item_index('Product', 7)).to eq(nil)
    end

    it "return nil for empty shopping cart" do     
      session[:shopping_cart_item] = []
      session[:shopping_cart_item_type] = []
      session[:shopping_cart_item_qty] = [] 
      session[:shopping_cart_item_package_type] = [] 
      session[:wishlist_item] = []  
      expect(subject.shopping_cart_item_index('Product', '2')).to eq(nil) 
    end
  end


  describe "#check_shopping_cart_stock" do

    context "with user" do
      let(:product1) { Fabricate(:product, stock: 7)}
      let(:product2) { Fabricate(:product, stock:70)}
      let(:jewelry) { Fabricate(:jewelry)}
      let(:essential_oil) { Fabricate(:essential_oil)}
      let!(:user) { Fabricate(:user) }
      let!(:item1) { Fabricate(:shopping_cart_item, position: user, sellable: product1, qty: 2) } 
      let!(:item2) { Fabricate(:shopping_cart_item, position: user, sellable: product2, qty: 4) }
      let!(:item_with_no_stock1) { Fabricate(:shopping_cart_item, position: user, sellable: jewelry, qty: 2) } 
      let!(:item_with_no_stock1) { Fabricate(:shopping_cart_item, position: user, sellable: essential_oil, package_type: '5ml', qty: 4) }
      
      before do
        set_current_user(user)
      end

      context "without out of stock item" do
        it "return true" do
          expect(subject.check_shopping_cart_stock).to eq(true)
        end

        it "does not update item" do
          subject.check_shopping_cart_stock
          expect(ShoppingCartItem.find(item1.id).qty).to eq(2)
          expect(ShoppingCartItem.find(item2.id).qty).to eq(4)
        end
      
      end    

      context "with out of stock item" do
        before do
          product2.update(stock: 3)
        end

        it "return false" do
          expect(subject.check_shopping_cart_stock).to eq(false)
        end
        
        it "update out of stock item" do
          subject.check_shopping_cart_stock
          expect(ShoppingCartItem.find(item1.id).qty).to eq(2)
          expect(ShoppingCartItem.find(item2.id).qty).to eq(3)
        end
      
      end
    end

    context "without user" do
      let(:product1) { Fabricate(:product, stock: 7)}
      let(:product2) { Fabricate(:product, stock:70)}
      let(:jewelry) { Fabricate(:jewelry)}
      let(:essential_oil) { Fabricate(:essential_oil)}

      before do
      session[:shopping_cart_item] = [product1.id.to_s, product2.id.to_s, jewelry.id.to_s, essential_oil.id.to_s]
      session[:shopping_cart_item_type] = ['Product','Product', 'Jewelry', 'EssentialOil']
      session[:shopping_cart_item_qty] = ['2','4','7','7'] 
      session[:shopping_cart_item_package_type] = [nil, '50ml', nil, nil] 
      end

      context "without out of stock item" do
        it "return true" do
          expect(subject.check_shopping_cart_stock).to eq(true)
        end

        it "does not update item" do
          subject.check_shopping_cart_stock
          expect(session[:shopping_cart_item_qty]).to eq(['2','4','7','7'])
        end
      
      end    

      context "with out of stock item" do
        before do
          product2.update(stock: 3)
        end

        it "return false" do
          expect(subject.check_shopping_cart_stock).to eq(false)
        end
        
        it "update out of stock item" do
          subject.check_shopping_cart_stock
          expect(session[:shopping_cart_item_qty]).to eq(['2','3','7','7'])
        end

      end
    end

  end

end