require 'spec_helper'

describe User do

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it {should have_many(:shopping_cart_items)}
  it {should have_many(:wishlist_items)}
  it {should have_many(:orders)}
  it {should have_many(:addresses)}

  it 'set the role by default to customer' do
    user = User.create(name: 'Maya', email:'maya@gmail.com', password: 'mayale')
    expect(user.role).to eq('customer')
  end

  describe "#set_user_name" do
    it "set the name to user without name input" do
      sara = User.create(email: "sara@mitmail.com", password: "123")
      expect(sara.name).to eq("sara")
    end
  end

  describe "#english_name" do
    it "return english name if the name givvenn is not english" do
      sara = User.create(email: "sara@mitmail.com", name: 'שרלה')
      expect(sara.english_name).to eq("sara")
    end

    it "return the name if the name givvenn is partly english" do
      sara = User.create(email: "sara@mitmail.com", name: 'nyuuשרלה')
      expect(sara.english_name).to eq(sara.name)
    end

  end

  describe "#total_bill" do
    it "return the total bill" do
      user = Fabricate(:user)
      product1 = Fabricate(:product)
      product2 = Fabricate(:product)
      ShoppingCartItem.create(position: user, sellable: product1, qty: 7)
      ShoppingCartItem.create(position: user, sellable: product2, qty: 1)
      expect(user.total_bill).to eq(7*product1.price + product2.price)
    end
  end

  describe "#shipping_addresses" do
    let(:user) {Fabricate(:user)}
    let!(:shipping_address) {Fabricate(:address, shipping: true, billing: false, user: user)}
    let!(:shipping_address2) {Fabricate(:address, shipping: true, billing: true, user: user)}
    let!(:billing_address) {Fabricate(:address, shipping: false, billing: true, user: user)}

    it "return all addresses whene shipping is true" do
      expect(user.shipping_addresses.count).to eq(2)
      expect(user.shipping_addresses).to include(shipping_address)
      expect(user.shipping_addresses).to include(shipping_address2)
    end

    it "does not return addresses that shipping is false" do
      expect(user.shipping_addresses).to_not include(billing_address)
    end

    it "return empty array if user does not have shipping addresses" do
      shipping_address.delete
      shipping_address2.delete
      expect(user.shipping_addresses).to eq([])
    end
  end

  describe "#billing_addresses" do
    let(:user) {Fabricate(:user)}
    let!(:billing_address) {Fabricate(:address, billing: true, shipping: false, user: user)}
    let!(:billing_address2) {Fabricate(:address, billing: true, shipping: true, user: user)}
    let!(:shipping_address) {Fabricate(:address, billing: false, shipping: true, user: user)}

    it "return all addresses whene shipping is true" do
      expect(user.billing_addresses.count).to eq(2)
      expect(user.billing_addresses).to include(billing_address)
      expect(user.billing_addresses).to include(billing_address2)
    end

    it "does not return addresses that shipping is false" do
      expect(user.billing_addresses).to_not include(shipping_address)
    end

    it "return empty array if user does not have shipping addresses" do
      billing_address.delete
      billing_address2.delete
      expect(user.billing_addresses).to eq([])
    end
  end

  describe '#generate_token' do
    it "set the soken" do
      user = Fabricate(:user)
      user.generate_token
      expect(user.token).to_not be_nil
    end
  end
  

  describe "#delete_reset_password_token" do
    it "set user token to nil" do
      user = Fabricate(:user)
      user.generate_token
      user.delete_reset_password_token
      expect(user.token).to be_nil
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:user) }
  end
  
end