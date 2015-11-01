class JewelryCrystal <ActiveRecord::Base
  include Sluggable
  sluggable_column :slug_column
  
  validates_presence_of :jewelry ,:crystal
  validates_numericality_of :price, {only_float: true, greater_than_or_equal_to: 0}

  belongs_to :jewelry
  belongs_to :crystal

  has_many :shopping_cart_items, as: :sellable
  has_many :wishlist_items, as: :sellable

  delegate :image, to: :jewelry
  delegate :name, to: :jewelry
  delegate :english_name, to: :jewelry

  def slug_column
    Array.new(8){[*"A".."Z", *"0".."9"].sample}.join
  end

  def last_ordered
    orders.last.updated_at unless orders.empty?
  end

  def orders
    shopping_cart_items.where("position_type ILIKE ? ", Order).order('updated_at')
  end

end
