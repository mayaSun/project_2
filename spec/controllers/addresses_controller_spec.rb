require 'spec_helper'

describe AddressesController do
  
  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end
  
  describe 'GET index' do
    it "set shipping addresses" do
      set_current_user()
      get :index
      expect(assigns(:shipping_addresses)).to eq([])
    end

    it "set billing addresses" do
      set_current_user()
      get :index
      expect(assigns(:billing_addresses)).to eq([])
    end
    
    it "redirect to home if not loggin" do
      get :index
      expect(response).to redirect_to home_path
    end
  end

  describe 'GET new' do
    it "set address" do
      set_current_user()
      get :new
      expect(assigns(:address)).to be_instance_of(Address)
    end

    it "redirect to home if not loggin" do
      get :index
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do

    context "with valid input" do
      
      let(:address_attributes) {Fabricate.attributes_for(:address)}
      before do
        set_current_user()
        post :create, address: address_attributes
      end

      it "set address" do
        expect(assigns(:address)).to be_instance_of(Address)
      end

      it "create new Address" do
        expect(Address.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirects back to index" do
        expect(response).to redirect_to addresses_path
      end

    end

    context "with invalid input" do
      
      let(:address_attributes) {Fabricate.attributes_for(:address, first_name: nil)}
      before do
        set_current_user()
        post :create, address: address_attributes
      end

      it "set address" do
        expect(assigns(:address)).to be_instance_of(Address)
      end

      it "does not create new Address" do
        expect(Address.count).to eq(0)
      end

      it "redirects back to new" do
        expect(response).to render_template :new
      end

    end

    it "redirect to home if not loggin" do
      get :index
      expect(response).to redirect_to home_path
    end
  end

  describe 'GET edit' do

    let(:user) {Fabricate(:user)}
    let(:address) {Fabricate(:address, user: user)}

    it "set address" do
      set_current_user(user)
      get :edit, id: address.slug
      expect(assigns(:address)).to be_instance_of(Address)
    end

    it "redirect to home if not loggin" do
      get :edit, id: address.slug
      expect(response).to redirect_to home_path
    end
  end

  describe 'PATCH update' do

    let(:user) {Fabricate(:user)}
    let(:address) {Fabricate(:address, user: user)}

    context "with valid input" do

      before do
        set_current_user(user)
        patch :update, id: address.slug ,address: {first_name: 'New name'}
      end

      it "set address" do
        expect(assigns(:address)).to be_instance_of(Address)
      end

      it "update the Address" do
        expect(Address.first.first_name).to eq('New name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirects back to index" do
        expect(response).to redirect_to addresses_path
      end

    end

    context "with invalid input" do
      
      before do
        set_current_user(user)
        patch :update, id: address.slug ,address: {first_name: nil}
      end

      it "set address" do
        expect(assigns(:address)).to be_instance_of(Address)
      end

      it "does not update the Address" do
        expect(Address.first.first_name).to eq(address.first_name)
      end

      it "redirects back to edit" do
        expect(response).to render_template :edit
      end

    end
  
    context "with invalid user" do

      before do
        set_current_user()
        patch :update, id: address.slug ,address: {first_name: 'New name'}
      end

      it "redirect to home path" do
        expect(response).to redirect_to home_path
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end  

    it "redirect to home if not loggin" do
      patch :update, id: address.slug ,address: {first_name: 'New name'}
      expect(response).to redirect_to home_path
    end

  end  

  describe 'DELETE destroy' do

    let(:user) {Fabricate(:user)}
    let(:address) {Fabricate(:address, user: user, billing: true, shipping: false)}

    it "does not delete the address" do
      set_current_user(user)
      delete :destroy, id: address.slug , type: 'billing'
      expect(Address.count).to eq(1)
    end

    context "with invalid user" do

      before do
        set_current_user()
        delete :destroy, id: address.slug , type: 'billing'
      end

      it "redirect to home path" do
        expect(response).to redirect_to home_path
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end 

    it "redirect to home if not loggin" do
      delete :destroy, id: address.slug , type: 'billing'
      expect(response).to redirect_to home_path
    end

  end

end