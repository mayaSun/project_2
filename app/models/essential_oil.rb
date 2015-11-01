class EssentialOil <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name
  
  validates_presence_of :name , :english_name

  mount_uploader :image, EssentialOilImageUploader
  validates_numericality_of :price_5ml, :price_10ml,:price_50ml, {only_float: true, greater_than_or_equal_to: 0}

  before_save :capitalize_name 
  after_initialize :defaults

  has_many :shopping_cart_items, as: :sellable
  has_many :wishlist_items, as: :sellable

  def defaults
     unless persisted?
      self.price_5ml ||= 0
      self.price_10ml ||= 0
      self.price_50ml ||= 0
    end
  end

  def package_weight(package_weight)
    if package_weight == '5ml'
      200
    elsif package_weight == '10ml'
      400
    else
      1000
    end
  end

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    EssentialOil.where("name ILIKE ? OR english_name ILIKE ? ", "%#{search_term}%", "%#{search_term}%")
  end 

  def last_ordered
    orders.last.updated_at unless orders.empty?
  end

  def orders
    shopping_cart_items.where("position_type ILIKE ? ", Order).order('updated_at')
  end

end