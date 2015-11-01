require 'spec_helper'

describe FreePlantsOrdersController do

  describe 'GET new' do
    it "set the @address veriable" do
      xhr :get, :new
      expect(assigns(:address)).to be_instance_of(Address)
    end
  end


  describe 'POST create' do
    context "with valid params" do
      let(:address_attributes) {Fabricate.attributes_for(:address)}
      before do
        xhr :post, :create, address: address_attributes, plants: ["רוזמרין", "לבנדר"], delivery_method: 'post mail'
      end
    
      it "create new address" do
        expect(Address.count).to eq(1)
      end

      it "create new free plants order" do
        expect(FreePlantsOrder.count).to eq(1)
      end

      it "send an e-mail"
    end

    context "with invalid address" do
      let(:address_attributes) {Fabricate.attributes_for(:address, city: nil)}
      before do
        xhr :post, :create, address: address_attributes, plants: ["רוזמרין", "לבנדר"], delivery_method: 'post mail'
      end
    
      it "does not create new address" do
        expect(Address.count).to eq(0)
      end

      it "does not create new free plants order" do
        expect(FreePlantsOrder.count).to eq(0)
      end

      it "does not send an e-mail"      
    end

    context "with invalid data" do
      let(:address_attributes) {Fabricate.attributes_for(:address)}
      before do
        xhr :post, :create, address: address_attributes, plants: ["רוזמרין", "לבנדר"], delivery_method: nil
      end
    
      it "does not create new address" do
        expect(Address.count).to eq(0)
      end

      it "does not create new free plants order" do
        expect(FreePlantsOrder.count).to eq(0)
      end

      it "does not send an e-mail" 
    end
  end

end