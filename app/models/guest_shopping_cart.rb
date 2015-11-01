class GuestShoppingCart

  attr_reader :qty, :sellable_id, :sellable_type, :package_type

  def initialize(params={})
    @qty = params[:qty].to_i
    @sellable_id = params[:sellable_id].to_i
    @sellable_type = params[:sellable_type]
    @package_type = params[:package_type]
  end

  def self.params_validated?(params={})
    Object.const_defined?(params[:sellable_type]) &&
    params[:sellable_type].constantize.find_by(id: params[:sellable_id]) && # I use find_by because it does not throw exeption
    (params[:sellable_type] != 'EssentialOil' || ['5ml', '10ml', '50ml'].include?(params[:package_type]) ) &&
    self.qty_validated?(params[:qty])
  end

  def self.qty_validated?(qty)
    qty.to_i > 0 &&
    qty.to_i == qty.to_f
  end

  def sellable
    sellable_type.constantize.find(sellable_id)
  end

  def id
    sellable_id
  end

  def name
    sellable.name
  end

  def english_name
    sellable.english_name
  end

  def image
    sellable.image
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

  def total_price
    qty * price
  end
end