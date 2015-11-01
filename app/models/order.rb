class Order <ActiveRecord::Base
  include Sluggable
  sluggable_column :slug_column

  validates_presence_of :shipping_address_id #, :billing_address_id, :delivery_method
  has_many :shopping_cart_items, as: :position
  belongs_to :user

  def slug_column
    Array.new(8){[*"A".."Z", *"0".."9"].sample}.join
  end

  def shipping_address
    Address.find_by(id: shipping_address_id)
  end

  def billing_address
    Address.find_by(id: billing_address_id)
  end

  def total_bill
    shopping_cart_items.map(&:total_price).inject(0, :+)
  end

  def shipping_bill
    if delivery_method == 'post_mail'
      Order.post_mail_shipping_bill(calculate_order_weight)
    elsif delivery_method == 'ups'
      return 40
    else 
      return 0
    end
  end

  def self.post_mail_shipping_bill(weight)
    if weight < 2000
      18.80
    elsif weight < 5000
      22
    elsif weight < 10000
      28.1
    else
      35.2
    end
  end

  def self.total_weight(item)
    if item.sellable_type == 'EssentialOil'
      return item.sellable.package_weight(item.package_type) * item.qty
    else
      return item.sellable.package_weight * item.qty
    end
  end

  def calculate_order_weight
    shopping_cart_items.map{|item| Order.total_weight(item)}.inject(0, :+)
  end

  def update_stock
    shopping_cart_items.each do |shopping_cart_item|
      if shopping_cart_item.sellable_type == 'Product'
        shopping_cart_item.sellable.update(stock: shopping_cart_item.sellable.stock - shopping_cart_item.qty)
      end
    end
  end

  def self.last_paid_orders
    Order.where("status LIKE ? ", 'Paid%').order('updated_at') 
  end

  def self.last_sent_orders 
    Order.where("status LIKE ? ", 'Sent').order('updated_at DESC')
  end

  def self.last_pending_orders
    Order.where("status LIKE ? ", 'Pending%').order('updated_at') 
  end

  def self.last_undefined_orders
    Order.where('status NOT IN (?)',['Sent','Pending', 'Paid'])
  end

  serialize :notification_params, Hash
  def paypal_url(shopping_cart, address=nil)
    values = {
      business: "holylandherbs@gmail.com",
      cmd: "_cart",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}/thank_you",
      invoice: id,
      currency_code: 'ILS',
      charset: 'utf-8', # To use hebrew
      notify_url: "#{Rails.application.secrets.app_host}/paypal_hook",
      shipping_1: shipping_bill
    }      
    shopping_cart.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.name,
        "item_number_#{index+1}" => item.sellable_id,
        "quantity_#{index+1}" => item.qty,
        "on0_#{index+1}" => item.sellable_type,
        "on1_#{index+1}" => item.package_type
      })
    end
    if address != nil
      values.merge!({
        address1: address.address_line1,
        address2: address.address_line2,
        city: address.city,
        country: address.country_code,
        email: address.email,
        first_name: address.first_name,
        last_name: address.last_name,
        zip: address.postal_code,
        night_phone_a: '972',
        night_phone_b: address.phone_number
      })
    end
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end