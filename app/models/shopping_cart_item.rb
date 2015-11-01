class ShoppingCartItem <ActiveRecord::Base
  belongs_to :sellable, :polymorphic => true
  belongs_to :position, :polymorphic => true
  validates_presence_of :sellable , :position
  validates_numericality_of :qty, {only_integer: true, greater_than_or_equal_to: 0}
  
  delegate :name, to: :sellable
  delegate :english_name, to: :sellable
  delegate :image, to: :sellable

  validate :check_essential_oil_package_type

  def total_price
    10 * qty
  end

  def price
    if sellable_type == "EssentialOil"
      case package_type
        when '5ml'
          return sellable.price_5ml
        when '10ml'
          return sellable.price_10ml
        when '50ml'
          return sellable.price_50ml          
      end    
    elsif sellable_type == "Product"
      case package_type
        when 'nurmal'
          return sellable.price
        when 'medium'
          return sellable.medium_package_price
        when 'big'
          return sellable.big_package_price
        else
          return sellable.price
      end       
    else  
      return sellable.price
    end
  end

  def check_essential_oil_package_type
    if sellable_type == "EssentialOil" &&  package_type != '5ml' && package_type != '10ml' && package_type != '50ml'
      errors.add(:package_type, "must be 5ml, 10ml or 50ml")
    end
  end

end 