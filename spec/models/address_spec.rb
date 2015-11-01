require 'spec_helper'

describe Address do

  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:address_line1)}
  it { should validate_presence_of(:city)}
  it { should validate_presence_of(:country_code)}
  it { should validate_presence_of(:email)}
  it {should belong_to(:user)}


  describe 'delete_type' do
    let!(:user) { Fabricate(:user) }
    let!(:address) { Fabricate(:address, shipping: true, billing: true, user: user)}
    let!(:billing_address) { Fabricate(:address, shipping: false, billing: true, user: user)}
    let!(:shipping_address) { Fabricate(:address, shipping: true, billing: false, user: user)}

    it "does not delete address of both type" do
      address.delete_type('billing')
      expect(user.addresses.count).to eq(3)
      expect(address.reload.billing).to eq(false)
      expect(address.reload.shipping).to eq(true)
    end

    it "delete only the type deleted" do
      address.delete_type('shipping')
      expect(user.addresses.count).to eq(3)
      expect(address.reload.billing).to eq(true)
      expect(address.reload.shipping).to eq(false)
    end

    it "delete the user from address if the type givven billing, is the only type exesit" do
      billing_address.delete_type('billing')
      expect(Address.count).to eq(3)
      expect(user.addresses.count).to eq(2)
    end

    it "delete the address if the type givven shipping, is the only type exesit" do
      shipping_address.delete_type('shipping')
      expect(Address.count).to eq(3)
      expect(user.addresses.count).to eq(2)
    end

    it "does not delete the address it the type givven does not exist" do
      billing_address.delete_type('shipping')
      shipping_address.delete_type('billing')
      expect(user.addresses.count).to eq(3)
    end
 
  end


  it_behaves_like "slugable" do
    let(:object) { Fabricate(:address) }
  end

end