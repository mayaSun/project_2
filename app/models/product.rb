class Product <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name
  
  belongs_to :category
  validates_presence_of :name , :english_name, :short_description,  :category, :price,  :image ,:quantity, :quantity_unit, :package_weight

  mount_uploader :image, ProductImageUploader
  validates_numericality_of :stock, :quantity, :package_weight, {only_integer: true, greater_than_or_equal_to: 0}
  validates_numericality_of :price, {only_float: true, greater_than_or_equal_to: 0}
  validate :check_nutritional_data

  has_many :shopping_cart_items, as: :sellable
  has_many :wishlist_items, as: :sellable

  has_many :product_medicinal_herbs
  has_many :medicinal_herbs, through: :product_medicinal_herbs

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    Product.where("name ILIKE ? OR english_name ILIKE ? ", "%#{search_term}%", "%#{search_term}%")
  end 

  def last_ordered
    orders.last.updated_at unless orders.empty?
  end

  def orders
    shopping_cart_items.where("position_type ILIKE ? ", Order).order('updated_at')
  end

  def check_nutritional_data
    if (energy != nil || carbohydrates != nil || protein != nil || fat != nil || saturated_fat != nil || cholesterol != nil || sodium != nil)
      if energy == nil  then  errors.add(:energy, "cannot be black, unless all the nutritional data is blank") end
      if carbohydrates == nil  then  errors.add(:carbohydrates, "cannot be black, unless all the nutritional data is blank") end
      if protein == nil  then  errors.add(:protein, "cannot be black, unless all the nutritional data is blank") end
      if fat == nil  then  errors.add(:fat, "cannot be black, unless all the nutritional data is blank") end
      if saturated_fat == nil  then  errors.add(:saturated_fat, "cannot be black, unless all the nutritional data is blank") end
      if cholesterol == nil  then  errors.add(:cholesterol, "cannot be black, unless all the nutritional data is blank") end
      if sodium == nil  then  errors.add(:sodium, "cannot be black, unless all the nutritional data is blank") end
    end
  end

  def is_food?
    energy != nil
  end

  def medicinal_herbs_text()
    medicinal_herbs.empty? ? '' :  medicinal_herbs.map(&:name).join(',')
  end

  def multiple_quantities?
    if medium_package_quantity || big_package_quantity
      return true
    else
      return false
    end
  end

end