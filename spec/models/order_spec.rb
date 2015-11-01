require 'spec_helper'

describe Order do

  it { should validate_presence_of(:shipping_address_id)}
  it {should have_many(:shopping_cart_items)}
  it {should belong_to(:user)}

  describe '#slug_column' do
    it "set the slug column" do
      Fabricate(:order)
      expect(Order.first.slug.length).to eq(8)
    end  
  end

  describe '#shipping_address' do

    let(:address) { Fabricate(:address) }
    let(:order) { Fabricate(:order, shipping_address_id: address.id) } 

    it 'retuen shipping address' do
      expect(order.shipping_address).to eq(address)
    end
    
    it 'return nil if there is no shipping address' do
      address.delete
      expect(order.shipping_address).to eq(nil)
    end

  end

  describe '#billing_address' do
    let(:address) { Fabricate(:address) }
    let(:order) { Fabricate(:order, billing_address_id: address.id) } 

    it 'retuen shipping address' do
      expect(order.billing_address).to eq(address)
    end
    
    it 'return nil if there is no shipping address' do
      address.delete
      expect(order.billing_address).to eq(nil)
    end
  end

  describe '#total_bill' do

    it 'set the total bill' do
      order = Fabricate(:order)
      product1 = Fabricate(:product)
      product2 = Fabricate(:product)
      ShoppingCartItem.create(position: order, sellable: product1, qty: 7)
      ShoppingCartItem.create(position: order, sellable: product2, qty: 3)
      expect(order.total_bill).to eq(product1.price*7 + product2.price*3)
    end
  end

  describe '#calculate_order_weight' do
    it "calculate the weight of the order" do
      product = Fabricate(:product)
      essential_oil = Fabricate(:essential_oil)
      jewelry = Fabricate(:jewelry)
      order = Fabricate(:order, delivery_method: 'post_mail')
      ShoppingCartItem.create(position: order, sellable: product, qty: 7)
      ShoppingCartItem.create(position: order, sellable: essential_oil, package_type: '5ml' , qty: 3)
      ShoppingCartItem.create(position: order, sellable: jewelry , qty: 2)
      expect(order.calculate_order_weight).to eq(7*product.package_weight + 3*essential_oil.package_weight('5ml') + 2*jewelry.package_weight)
    end
  end

  describe '#shipping_bill' do
    it "calculate the bill for post_mail order" do
      product = Fabricate(:product, package_weight: 1500)
      order = Fabricate(:order, delivery_method: 'post_mail')
      ShoppingCartItem.create(position: order, sellable: product, qty: 1)
      expect(order.shipping_bill).to eq(18.8)
    end

    it "calculate the bill for ups order" do
      product = Fabricate(:product, package_weight: 1500)
      order = Fabricate(:order, delivery_method: 'ups')
      ShoppingCartItem.create(position: order, sellable: product, qty: 1)
      expect(order.shipping_bill).to eq(40)
    end

    it "calculate the bill for pickup order" do
      product = Fabricate(:product, package_weight: 1500)
      order = Fabricate(:order, delivery_method: 'pickup')
      ShoppingCartItem.create(position: order, sellable: product, qty: 1)
      expect(order.shipping_bill).to eq(0)
    end
  end

  describe '#update_stock' do
    it "update the stock" do
      order = Fabricate(:order)
      product1 = Fabricate(:product, stock: 7)
      product2 = Fabricate(:product, stock: 70)
      ShoppingCartItem.create(position: order, sellable: product1, qty: 7)
      ShoppingCartItem.create(position: order, sellable: product2, qty: 3)
      order.update_stock
      expect(product1.reload.stock).to eq(0)
      expect(product2.reload.stock).to eq(67)
    end  

    it "does'nt do anything for essential oil and jewelry" do
      order = Fabricate(:order)
      jewelry = Fabricate(:jewelry)
      essential_oil = Fabricate(:essential_oil)
      ShoppingCartItem.create(position: order, sellable: jewelry, qty: 7)
      ShoppingCartItem.create(position: order, sellable: essential_oil, package_type: '5ml', qty: 3)
      expect(order.update_stock).to_not eq(nil)
    end 
  end

  describe '#last_paid_orders' do
    it "set the last order in the right order" do
      order3 = Fabricate(:order, status: 'Paid', updated_at: 3.days.ago)
      order2 = Fabricate(:order, status: 'Sent', updated_at: 2.days.ago)
      order0 = Fabricate(:order, status: 'Sent', updated_at: 0.days.ago)
      order1 = Fabricate(:order, status: 'Paid', updated_at: 1.days.ago)
      expect(Order.last_paid_orders).to eq([order3, order1])
    end
  end

  describe '#last_sent_orders' do
    it "set the last order in the right order" do
      order3 = Fabricate(:order, status: 'Paid', updated_at: 3.days.ago)
      order2 = Fabricate(:order, status: 'Sent', updated_at: 2.days.ago)
      order0 = Fabricate(:order, status: 'Sent', updated_at: 0.days.ago)
      order1 = Fabricate(:order, status: 'Paid', updated_at: 1.days.ago)
      expect(Order.last_sent_orders).to eq([order0, order2])
    end
  end

  describe '#last_pending_orders' do
    it "set the last order in the right order" do
      order3 = Fabricate(:order, status: 'Paid', updated_at: 3.days.ago)
      order2 = Fabricate(:order, status: 'Pending', updated_at: 2.days.ago)
      order0 = Fabricate(:order, status: 'Sent', updated_at: 0.days.ago)
      order1 = Fabricate(:order, status: 'Pending', updated_at: 1.days.ago)
      expect(Order.last_pending_orders).to eq([order2, order1])
    end
  end

  describe '#last_undefined_orders' do
    it "set the last order in the right order" do
      order3 = Fabricate(:order, status: 'Paid', updated_at: 3.days.ago)
      order2 = Fabricate(:order, status: 'Pending', updated_at: 2.days.ago)
      order0 = Fabricate(:order, status: 'Sent', updated_at: 0.days.ago)
      order1 = Fabricate(:order, status: 'Faud', updated_at: 1.days.ago)
      expect(Order.last_undefined_orders).to eq([order1])
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:order) }
  end

end