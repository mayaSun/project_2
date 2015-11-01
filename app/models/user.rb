class User <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name
  
  has_secure_password validations: false
  validates_presence_of :email 
  validates_uniqueness_of :email 
  after_validation :set_user_name
  validates_confirmation_of :password
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_many :shopping_cart_items, as: :position
  has_many :wishlist_items
  has_many :orders
  has_many :addresses

  def set_user_name
    if !self.name || self.name.length < 2
      if self.email
        self.name = self.email.split("@").first
      end   
    end     
  end

  def english_name
    if name.match(/[A-Za-z]+/)
      name      
    else
      self.email.split("@").first
    end
  end

  def total_bill(user=nil)
    shopping_cart_items.map(&:total_price).inject(0, :+)    
  end

  def shipping_addresses
    addresses.where(shipping: true)
  end

  def billing_addresses
    addresses.where(billing: true)
  end

  def generate_token
    update_column(:token, SecureRandom.urlsafe_base64)
  end

  def delete_reset_password_token
    update_column(:token, nil)
  end

end