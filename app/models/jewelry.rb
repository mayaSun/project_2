class Jewelry <ActiveRecord::Base
  include Sluggable
  sluggable_column :slug_column

  mount_uploader :image, JewelryImageUploader

  validates_presence_of :name , :english_name
  validates_numericality_of :price, {only_float: true, greater_than_or_equal_to: 0}

  has_many :jewelry_crystals
  has_many :crystals, through: :jewelry_crystals

  has_many :shopping_cart_items, as: :sellable
  has_many :wishlist_items, as: :sellable

  def slug_column
    Array.new(8){[*"A".."Z", *"0".."9"].sample}.join
  end

  def package_weight
    300
  end

  def last_ordered
    orders.last.updated_at unless orders.empty?
  end

  def orders
    shopping_cart_items.where("position_type ILIKE ? ", Order).order('updated_at')
  end

  def jewelry_crystal(crystal)
    jewelry_crystals.find_by(crystal_id: crystal)
  end

  def validate_jewelry_crystals_data(params = {})
    crystals_array = params.map{|o| o[1]}.delete_if{|x| x[:crystal_id].to_i <= 0}
    if crystals_array.map{|o| o[:crystal_id]}.uniq.size < crystals_array.size
      return 'The same crystal can not be added more then once'
    end
    crystals_array.each_with_index do |crystal, index|
      crystal_id = crystal[:crystal_id].to_i
      if crystal_id == 0
        return true
      elsif crystal[:price].to_i <= 0
        return 'Price must be positive number'  
      end
    end
    return true
  end

  def set_jewelry_crystals_data(params = {})
    crystals_array = params.map{|o| o[1]}.delete_if{|x| x[:crystal_id].to_i <= 0}
    size = jewelry_crystals.count
    crystals_array.each_with_index do |crystal, index|
      if index < size
        jewelry_crystals[index].update(crystal_id: crystal[:crystal_id].to_i, price: crystal[:price].to_i)
      else
        jewelry_crystals.create(crystal_id: crystal[:crystal_id].to_i, price: crystal[:price].to_i)
      end
    end
    if crystal_id && !jewelry_crystals.find_by(crystal_id: crystal_id)
      jewelry_crystals.create(crystal_id: crystal_id, price: price) 
    end
    if  crystals_array.size < size
      (crystals_array.size..size-1).each do |deleted_index| 
        jewelry_crystals[deleted_index].delete   
      end
    end
  end

end