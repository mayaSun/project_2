class Crystal <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name

  include PrevNext
  
  validates_presence_of :name , :english_name #, :image 

  mount_uploader :image, CrystalImageUploader

  has_many :jewelry_crystals
  has_many :jewelries, through: :jewelry_crystals

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    Crystal.where("name ILIKE ? OR english_name ILIKE ? ", "%#{search_term}%", "%#{search_term}%")
  end 

end