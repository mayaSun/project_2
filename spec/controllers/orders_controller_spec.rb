require 'spec_helper'

describe OrdersController do

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'GET show' do

    context "with admin user" do
      it "set @order veriable" do
        order = Fabricate(:order)
        set_current_user(Fabricate(:admin))
        get :show, id: order.slug
        expect(assigns(:order)).to eq(order)
      end
    end

    context "with valid user" do
      it "set @order verible" do
        user = Fabricate(:user)
        order = Fabricate(:order, user: user)
        get :show, id: order.slug
        expect(assigns(:order)).to eq(order)
      end
    end

    context "with invalid user" do

      let(:order) { Fabricate(:order) }
      before do
        set_current_user()
        get :show, id: order.slug
      end

      it "redirect to back" do
        expect(response).to redirect_to "where_i_came_from"
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end
 
    context "with no user" do

      let(:order) { Fabricate(:order) }
      before do
        get :show, id: order.slug
      end

      it "redirect to back" do
        expect(response).to redirect_to "where_i_came_from"
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end   
    
  end

  describe 'GET new' do

    context "with non-empty shopping cart" do

      let(:product) {Fabricate(:product)}
      before do
        session[:shopping_cart_item] = [product.id.to_s]
        session[:shopping_cart_item_qty] = [2.to_s]
        session[:shopping_cart_item_type] = ['Product']
        session[:shopping_cart_item_package_type] = []
      end

      it "set the @shipping_address veriable" do
        get :new
        expect(assigns(:shipping_address)).to be_instance_of(Address)
      end

      it "render new" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "with empty shopping cart" do
      it "redirects back to the referring page" do
        get :new
        expect(response).to redirect_to "where_i_came_from"
      end

      it "set notice message" do
        get :new
        expect(flash[:notice]).to be_present
      end
    end
  end


  describe 'POST create' do

    context "with valid params" do

      let(:shipping_address_attributes) {Fabricate.attributes_for(:address)}
      
      context "with billing address same address as shipping" do
        
        let(:shipping_address_attributes) {Fabricate.attributes_for(:address)}
        before do
          post :create, address: shipping_address_attributes, billing: true, accept_terms_and_conditions: true , delivery_method: 'post_mail'
        end

        it "set the @shipping_address veriable" do
          expect(assigns(:shipping_address)).to be_instance_of(Address)
        end

        it "set the @order veriable" do
          expect(assigns(:order)).to be_instance_of(Order)
        end

        it "create address" do
          expect(Address.count).to eq(1)
        end

        it "create order" do
          expect(Order.count).to eq(1)
        end

        it "create address with referenced address" do
          expect(Order.first.shipping_address).to eq(Address.first)
        end

        it "set shipping address attributes" do
          expect(Address.first.address_line1).to eq(shipping_address_attributes[:address_line1])
          expect(Address.first.address_line2).to eq(shipping_address_attributes[:address_line2])
          expect(Address.first.city).to eq(shipping_address_attributes[:city])
          #expect(session[:shipping_address_attributes]["country_code"]).to eq(shipping_address_attributes[:country_code])
          expect(Address.first.email).to eq(shipping_address_attributes[:email])
          expect(Address.first.first_name).to eq(shipping_address_attributes[:first_name])
          expect(Address.first.last_name).to eq(shipping_address_attributes[:last_name])
          expect(Address.first.phone_number).to eq(shipping_address_attributes[:phone_number])
          expect(Address.first.postal_code).to eq(shipping_address_attributes[:postal_code])
          expect(Address.first.state_code).to eq(shipping_address_attributes[:state_code])
          expect(Address.first.billing).to eq(true)
        end
        
        it "redirect to paypal" do
          expect(response).to redirect_to Order.first.paypal_url([], Address.first)
        end
      end

      context "with billing address not the same address as shipping" do
                
        let(:shipping_address_attributes) {Fabricate.attributes_for(:address)}
        before do
          post :create, address: shipping_address_attributes, billing: false, accept_terms_and_conditions: true 
        end

        it "set the @shipping_address veriable" do
          expect(assigns(:shipping_address)).to be_instance_of(Address)
        end

        it "set the @order veriable" do
          expect(assigns(:order)).to be_instance_of(Order)
        end

        it "create address" do
          expect(Address.count).to eq(1)
        end

        it "create order" do
          expect(Order.count).to eq(1)
        end

        it "create order with referenced address" do
          expect(Order.first.shipping_address).to eq(Address.first)
        end

        it "set shipping address attributes" do
          expect(Address.first.address_line1).to eq(shipping_address_attributes[:address_line1])
          expect(Address.first.address_line2).to eq(shipping_address_attributes[:address_line2])
          expect(Address.first.city).to eq(shipping_address_attributes[:city])
          #expect(session[:shipping_address_attributes]["country_code"]).to eq(shipping_address_attributes[:country_code])
          expect(Address.first.email).to eq(shipping_address_attributes[:email])
          expect(Address.first.first_name).to eq(shipping_address_attributes[:first_name])
          expect(Address.first.last_name).to eq(shipping_address_attributes[:last_name])
          expect(Address.first.phone_number).to eq(shipping_address_attributes[:phone_number])
          expect(Address.first.postal_code).to eq(shipping_address_attributes[:postal_code])
          expect(Address.first.state_code).to eq(shipping_address_attributes[:state_code])
          expect(Address.first.billing).to eq(nil)
        end
        
        it "redirect to paypal" do
          expect(response).to redirect_to Order.first.paypal_url([])
        end
        
      end
    end

    context "with invalid params" do

      let(:shipping_address_attributes) {Fabricate.attributes_for(:address, city: nil)}
      before do
        post :create, address: shipping_address_attributes, accept_terms_and_conditions: true 
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "set the @shipping_address veriable" do
        expect(assigns(:shipping_address)).to be_instance_of(Address)
      end

      it "does not create a address in the database" do
        expect(Address.count).to eq(0)
      end

      it "does not create a order in the database" do
        expect(Order.count).to eq(0)
      end
    end

    context "without confirmation of the term and condition" do
      let(:shipping_address_attributes) {Fabricate.attributes_for(:address)}
      before do
        post :create, address: shipping_address_attributes 
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "set the @shipping address veriable" do
        expect(assigns(:shipping_address)).to be_instance_of(Address)
      end

      it "does not create a address in the database" do
        expect(Address.count).to eq(0)
      end

      it "does not create a order in the database" do
        expect(Address.count).to eq(0)
      end
    end

    context "with out of stock product" do
    
      let(:product) {Fabricate(:product, stock: 2)}
      let(:shipping_address_attributes) {Fabricate.attributes_for(:address)}
      before do
        session[:shopping_cart_item] = [product.id.to_s]
        session[:shopping_cart_item_qty] = [3.to_s]
        session[:shopping_cart_item_type] = ['Product'] 
        session[:shopping_cart_item_package_type] = [] 
        post :create, address: shipping_address_attributes, billing: true, accept_terms_and_conditions: true
      end                  

      it "fix the user shopping cart item qty" do
        expect(session[:shopping_cart_item_qty][0]).to eq("2")
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render template new" do
        expect(response).to render_template :new
      end

      it "does not create a address in the database" do
        expect(Address.count).to eq(0)
      end

      it "does not create a order in the database" do
        expect(Address.count).to eq(0)
      end

    end    
  end

  describe 'POST paypal_hook' do

    after { ActionMailer::Base.deliveries.clear }

    let!(:product1) { Fabricate(:product, stock: 7) }
    let!(:product2) { Fabricate(:product, stock: 7) }
    let!(:address) { Fabricate(:address) }
    let!(:order) { Fabricate(:order, shipping_address_id: address.id, billing_address_id: nil) }

    context "with payment status Complete" do
      
      before do
        params = {
        "mc_gross"=>"20.00",
        "invoice"=> order.id.to_s,
        "protection_eligibility"=>"Eligible",
        "address_status"=>"confirmed",
        "item_number1"=> product1.id.to_s,
        "item_number2"=> product2.id.to_s,
        "tax"=>"0.00",
        "payer_id"=>"VQSCAFC8XM9MU",
        "address_street"=>"1 Main St",
        "payment_date"=>"03:23:26 Sep 20, 2015 PDT",
        "option_selection1_1"=>"",
        "payment_status"=>"Completed",
        "charset"=>"UTF-8",
        "address_zip"=>"95131",
        "mc_shipping"=>"0.00",
        "mc_handling"=>"0.00",
        "first_name"=>"test",
        "mc_fee"=>"1.98",
        "address_country_code"=>"US",
        "address_name"=>"test buyer",
        "notify_version"=>"3.8",
        "custom"=>"",
        "payer_status"=>"verified",
        "business"=>"holylandherbs@gmail.com",
        "address_country"=>"United States",
        "num_cart_items"=>"2",
        "mc_handling1"=>"0.00",
        "address_city"=>"San Jose",
        "verify_sign"=>"ANpfIu0VB9lz5OXHQ0LaBa4EcT.2AQgFzWpjzWzABBDzTqDPBh0x3TQ7",
        "payer_email"=>"maya166-buyer@gmail.com",
        "mc_shipping1"=>"0.00",
        "tax1"=>"0.00",
        "option_name1_1"=>"Product",
        "option_name1_2"=>"Product",
        "txn_id"=>"2G391977C7532152L",
        "payment_type"=>"instant",
        "option_selection2_1"=>"",
        "last_name"=>"buyer",
        "address_state"=>"CA",
        "item_name1"=>"לוונדר",
        "receiver_email"=>"holylandherbs@gmail.com",
        "payment_fee"=>"",
        "quantity1"=>"1",
        "quantity2"=>"2",
        "receiver_id"=>"NP6NXKQCNSSUY",
        "txn_type"=>"cart",
        "mc_gross_1"=>"20.00",
        "mc_currency"=>"ILS",
        "residence_country"=>"US",
        "test_ipn"=>"1",
        "transaction_subject"=>"",
        "payment_gross"=>"",
        "memo"=>"maya maya",
        "ipn_track_id"=>"fc6e5d8252c7d",
        "controller"=>"orders",
        "action"=>"paypal_hook"}
        post :paypal_hook, params
      end

      it "set order with correct status" do
        expect(Order.first.status).to eq('Paid')
      end

      it "create shopping cart item" do
        expect(ShoppingCartItem.count).to eq(2)
      end

      it "create shopping cart item with the reference order" do
        expect(ShoppingCartItem.first.position).to eq(Order.first)
        expect(ShoppingCartItem.second.position).to eq(Order.first)
      end

      it "reduce the product stock" do
        expect(product1.reload.stock).to eq(6)
        expect(product2.reload.stock).to eq(5)
      end

      it "save the billing address if not exist" do
        expect(Order.first.billing_address.first_name).to eq("test")
        expect(Order.first.billing_address.last_name).to eq("buyer")
        expect(Order.first.billing_address.address_line1).to eq("1 Main St")
        expect(Order.first.billing_address.city).to eq("San Jose")
        expect(Order.first.billing_address.country_code).to eq("US")
        expect(Order.first.billing_address.state_code).to eq("CA")
        expect(Order.first.billing_address.postal_code).to eq("95131")
        expect(Order.first.billing_address.email).to eq("maya166-buyer@gmail.com")
        expect(Order.first.billing_address.status).to eq("maya maya")
        expect(Order.first.billing_address.billing).to eq(true) 
        expect(Order.first.billing_address.shipping).to eq(nil)        
      end

      it "send mail to costumer with order summary" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(product1.name)
        expect(message.body).to have_content(product2.name)
        expect(message.body).to have_content(product1.price)
        expect(message.body).to have_content(product2.price)  
        expect(message.body).to have_content(Order.first.total_bill)      
      end
    
      it "send mail to the billing address email" do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([Order.first.billing_address.email])
      end

      it "send mail to costumer with shipping addrss details" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(address.first_name)
        expect(message.body).to have_content(address.last_name)
        expect(message.body).to have_content(address.city)
        expect(message.body).to have_content(address.address_line1)  
        expect(message.body).to have_content(address.address_line2)      
      end

    end

    context "with payment status Pending" do

      before do
        params = {
          "mc_gross"=>"20.00",
          "invoice"=> order.id.to_s,
          "protection_eligibility"=>"Eligible",
          "address_status"=>"confirmed",
          "item_number1"=> product1.id.to_s,
          "item_number2"=> product2.id.to_s,
          "tax"=>"0.00",
          "payer_id"=>"VQSCAFC8XM9MU",
          "address_street"=>"1 Main St",
          "payment_date"=>"03:23:26 Sep 20, 2015 PDT",
          "option_selection1_1"=>"",
          "payment_status"=>"Pending",
          "charset"=>"UTF-8",
          "address_zip"=>"95131",
          "mc_shipping"=>"0.00",
          "mc_handling"=>"0.00",
          "first_name"=>"test",
          "mc_fee"=>"1.98",
          "address_country_code"=>"US",
          "address_name"=>"test buyer",
          "notify_version"=>"3.8",
          "custom"=>"",
          "payer_status"=>"verified",
          "business"=>"holylandherbs@gmail.com",
          "address_country"=>"United States",
          "num_cart_items"=>"2",
          "mc_handling1"=>"0.00",
          "address_city"=>"San Jose",
          "verify_sign"=>"ANpfIu0VB9lz5OXHQ0LaBa4EcT.2AQgFzWpjzWzABBDzTqDPBh0x3TQ7",
          "payer_email"=>"maya166-buyer@gmail.com",
          "mc_shipping1"=>"0.00",
          "tax1"=>"0.00",
          "option_name1_1"=>"Product",
          "option_name1_2"=>"Product",
          "txn_id"=>"2G391977C7532152L",
          "payment_type"=>"instant",
          "option_selection2_1"=>"",
          "last_name"=>"buyer",
          "address_state"=>"CA",
          "item_name1"=>"לוונדר",
          "receiver_email"=>"holylandherbs@gmail.com",
          "payment_fee"=>"",
          "quantity1"=>"1",
          "quantity2"=>"2",
          "receiver_id"=>"NP6NXKQCNSSUY",
          "txn_type"=>"cart",
          "mc_gross_1"=>"20.00",
          "mc_currency"=>"ILS",
          "residence_country"=>"US",
          "test_ipn"=>"1",
          "transaction_subject"=>"",
          "payment_gross"=>"",
          "memo"=>"maya maya",
          "ipn_track_id"=>"fc6e5d8252c7d",
          "controller"=>"orders",
          "action"=>"paypal_hook"}
          post :paypal_hook, params

      end

      it "set order with corect status" do
        expect(Order.first.status).to eq('Pending')
      end

      it "does not create shopping cart item" do
        expect(ShoppingCartItem.count).to eq(2)
      end

      it "does not reduce the product stock" do
        expect(product1.reload.stock).to eq(7)
        expect(product2.reload.stock).to eq(7)
      end

      it "send mail to costumer with order summary" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(product1.name)
        expect(message.body).to have_content(product2.name)
        expect(message.body).to have_content(product1.price)
        expect(message.body).to have_content(product2.price)  
        expect(message.body).to have_content(Order.first.total_bill)      
      end
    
      it "send mail to the billing address email" do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([Order.first.billing_address.email])
      end

      it "send mail to costumer with shipping addrss details" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(address.first_name)
        expect(message.body).to have_content(address.last_name)
        expect(message.body).to have_content(address.city)
        expect(message.body).to have_content(address.address_line1)  
        expect(message.body).to have_content(address.address_line2)      
      end
      
    end

    context "with payment status Pending then Complete" do
      
      before do
        params = {
        "mc_gross"=>"20.00",
        "invoice"=> order.id.to_s,
        "protection_eligibility"=>"Eligible",
        "address_status"=>"confirmed",
        "item_number1"=> product1.id.to_s,
        "item_number2"=> product2.id.to_s,
        "tax"=>"0.00",
        "payer_id"=>"VQSCAFC8XM9MU",
        "address_street"=>"1 Main St",
        "payment_date"=>"03:23:26 Sep 20, 2015 PDT",
        "option_selection1_1"=>"",
        "payment_status"=>"Completed",
        "charset"=>"UTF-8",
        "address_zip"=>"95131",
        "mc_shipping"=>"0.00",
        "mc_handling"=>"0.00",
        "first_name"=>"test",
        "mc_fee"=>"1.98",
        "address_country_code"=>"US",
        "address_name"=>"test buyer",
        "notify_version"=>"3.8",
        "custom"=>"",
        "payer_status"=>"verified",
        "business"=>"holylandherbs@gmail.com",
        "address_country"=>"United States",
        "num_cart_items"=>"2",
        "mc_handling1"=>"0.00",
        "address_city"=>"San Jose",
        "verify_sign"=>"ANpfIu0VB9lz5OXHQ0LaBa4EcT.2AQgFzWpjzWzABBDzTqDPBh0x3TQ7",
        "payer_email"=>"maya166-buyer@gmail.com",
        "mc_shipping1"=>"0.00",
        "tax1"=>"0.00",
        "option_name1_1"=>"Product",
        "option_name1_2"=>"Product",
        "txn_id"=>"2G391977C7532152L",
        "payment_type"=>"instant",
        "option_selection2_1"=>"",
        "last_name"=>"buyer",
        "address_state"=>"CA",
        "item_name1"=>"לוונדר",
        "receiver_email"=>"holylandherbs@gmail.com",
        "payment_fee"=>"",
        "quantity1"=>"1",
        "quantity2"=>"2",
        "receiver_id"=>"NP6NXKQCNSSUY",
        "txn_type"=>"cart",
        "mc_gross_1"=>"20.00",
        "mc_currency"=>"ILS",
        "residence_country"=>"US",
        "test_ipn"=>"1",
        "transaction_subject"=>"",
        "payment_gross"=>"",
        "memo"=>"maya maya",
        "ipn_track_id"=>"fc6e5d8252c7d",
        "controller"=>"orders",
        "action"=>"paypal_hook"}
        order.update_attributes(billing_address_id: address.id, status: 'Pending')
        order.shopping_cart_items.create(sellable: product1, qty: 1)
        order.shopping_cart_items.create(sellable: product2, qty: 2)
        post :paypal_hook, params
      end

      it "set order with corect status" do
        expect(Order.first.status).to eq('Paid')
      end

      it "does not create new shopping cart item" do
        expect(ShoppingCartItem.count).to eq(2)
      end

      it "create shopping cart item with the reference order" do
        expect(ShoppingCartItem.first.position).to eq(Order.first)
        expect(ShoppingCartItem.second.position).to eq(Order.first)
      end

      it "reduce the product stock" do
        expect(product1.reload.stock).to eq(6)
        expect(product2.reload.stock).to eq(5)
      end


      it "send mail to costumer with order summary" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(product1.name)
        expect(message.body).to have_content(product2.name)
        expect(message.body).to have_content(product1.price)
        expect(message.body).to have_content(product2.price)  
        expect(message.body).to have_content(Order.first.total_bill)      
      end
    
      it "send mail to the billing address email" do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([Order.first.billing_address.email])
      end

      it "send mail to costumer with shipping addrss details" do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content(address.first_name)
        expect(message.body).to have_content(address.last_name)
        expect(message.body).to have_content(address.city)
        expect(message.body).to have_content(address.address_line1)  
        expect(message.body).to have_content(address.address_line2)      
      end
    end

    context "with Fraud Receiver" do
      before do
        params = {
          "mc_gross"=>"20.00",
          "invoice"=> order.id.to_s,
          "protection_eligibility"=>"Eligible",
          "address_status"=>"confirmed",
          "item_number1"=> product1.id.to_s,
          "item_number2"=> product2.id.to_s,
          "tax"=>"0.00",
          "payer_id"=>"VQSCAFC8XM9MU",
          "address_street"=>"1 Main St",
          "payment_date"=>"03:23:26 Sep 20, 2015 PDT",
          "option_selection1_1"=>"",
          "payment_status"=>"Completed",
          "charset"=>"UTF-8",
          "address_zip"=>"95131",
          "mc_shipping"=>"0.00",
          "mc_handling"=>"0.00",
          "first_name"=>"test",
          "mc_fee"=>"1.98",
          "address_country_code"=>"US",
          "address_name"=>"test buyer",
          "notify_version"=>"3.8",
          "custom"=>"",
          "payer_status"=>"verified",
          "business"=>"holylandherbs@gmail.com",
          "address_country"=>"United States",
          "num_cart_items"=>"2",
          "mc_handling1"=>"0.00",
          "address_city"=>"San Jose",
          "verify_sign"=>"ANpfIu0VB9lz5OXHQ0LaBa4EcT.2AQgFzWpjzWzABBDzTqDPBh0x3TQ7",
          "payer_email"=>"maya166-buyer@gmail.com",
          "mc_shipping1"=>"0.00",
          "tax1"=>"0.00",
          "option_name1_1"=>"Product",
          "option_name1_2"=>"Product",
          "txn_id"=>"2G391977C7532152L",
          "payment_type"=>"instant",
          "option_selection2_1"=>"",
          "last_name"=>"buyer",
          "address_state"=>"CA",
          "item_name1"=>"לוונדר",
          "receiver_email"=>"olylandherbs@gmail.com",
          "payment_fee"=>"",
          "quantity1"=>"1",
          "quantity2"=>"2",
          "receiver_id"=>"NP6NXKQCNSSUY",
          "txn_type"=>"cart",
          "mc_gross_1"=>"20.00",
          "mc_currency"=>"ILS",
          "residence_country"=>"US",
          "test_ipn"=>"1",
          "transaction_subject"=>"",
          "payment_gross"=>"",
          "ipn_track_id"=>"fc6e5d8252c7d",
          "controller"=>"orders",
          "action"=>"paypal_hook"}
          post :paypal_hook, params
      end

      it "set order with corect status" do
        expect(Order.first.status).to eq('Fraud Receiver')
      end

      it "create shopping cart item" do
        expect(ShoppingCartItem.count).to eq(2)
      end

      it "create shopping cart item with the reference order" do
        expect(ShoppingCartItem.first.position).to eq(Order.first)
        expect(ShoppingCartItem.second.position).to eq(Order.first)
      end

      it "does not reduce the product stock" do
        expect(product1.reload.stock).to eq(7)
        expect(product2.reload.stock).to eq(7)
      end

      it "send mail to costumer with order summary"
    end

    context "with duplication transaction ID ans status complete" do
      before do
        params = {
        "mc_gross"=>"20.00",
        "invoice"=> order.id.to_s,
        "protection_eligibility"=>"Eligible",
        "address_status"=>"confirmed",
        "item_number1"=> product1.id.to_s,
        "item_number2"=> product2.id.to_s,
        "tax"=>"0.00",
        "payer_id"=>"VQSCAFC8XM9MU",
        "address_street"=>"1 Main St",
        "payment_date"=>"03:23:26 Sep 20, 2015 PDT",
        "option_selection1_1"=>"",
        "payment_status"=>"Completed",
        "charset"=>"UTF-8",
        "address_zip"=>"95131",
        "mc_shipping"=>"0.00",
        "mc_handling"=>"0.00",
        "first_name"=>"test",
        "mc_fee"=>"1.98",
        "address_country_code"=>"US",
        "address_name"=>"test buyer",
        "notify_version"=>"3.8",
        "custom"=>"",
        "payer_status"=>"verified",
        "business"=>"holylandherbs@gmail.com",
        "address_country"=>"United States",
        "num_cart_items"=>"2",
        "mc_handling1"=>"0.00",
        "address_city"=>"San Jose",
        "verify_sign"=>"ANpfIu0VB9lz5OXHQ0LaBa4EcT.2AQgFzWpjzWzABBDzTqDPBh0x3TQ7",
        "payer_email"=>"maya166-buyer@gmail.com",
        "mc_shipping1"=>"0.00",
        "tax1"=>"0.00",
        "option_name1_1"=>"Product",
        "option_name1_2"=>"Product",
        "txn_id"=>"2G391977C7532152L",
        "payment_type"=>"instant",
        "option_selection2_1"=>"",
        "last_name"=>"buyer",
        "address_state"=>"CA",
        "item_name1"=>"לוונדר",
        "receiver_email"=>"holylandherbs@gmail.com",
        "payment_fee"=>"",
        "quantity1"=>"1",
        "quantity2"=>"2",
        "receiver_id"=>"NP6NXKQCNSSUY",
        "txn_type"=>"cart",
        "mc_gross_1"=>"20.00",
        "mc_currency"=>"ILS",
        "residence_country"=>"US",
        "test_ipn"=>"1",
        "transaction_subject"=>"",
        "payment_gross"=>"",
        "ipn_track_id"=>"fc6e5d8252c7d",
        "controller"=>"orders",
        "action"=>"paypal_hook"}
        post :paypal_hook, params  
        post :paypal_hook, params      
      end

      it "does not create shopping cart items inthe second time" do
        expect(ShoppingCartItem.count).to eq(2)
      end

      it "does not reduce the product stock in the secound time" do
        expect(product1.reload.stock).to eq(6)
        expect(product2.reload.stock).to eq(5)
      end

    end

  end

end