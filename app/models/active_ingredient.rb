class ActiveIngredient <ActiveRecord::Base
    
  include Sluggable
  sluggable_column :english_name

  validates_presence_of :name, :english_name

  has_many :medicinal_herb_active_ingredients
  has_many :medicinal_herbs, through: :medicinal_herb_active_ingredients

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    ActiveIngredient.where("name ILIKE ? OR english_name ILIKE ? ", "%#{search_term}%", "%#{search_term}%")
  end 

end