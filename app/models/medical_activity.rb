class MedicalActivity <ActiveRecord::Base
    
  include Sluggable
  sluggable_column :english_name

  validates_presence_of :name, :english_name

  has_many :medicinal_herb_medical_activities
  has_many :medicinal_herbs, through: :medicinal_herb_medical_activities

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    MedicalActivity.where("name ILIKE ? OR english_name ILIKE ? ", "%#{search_term}%", "%#{search_term}%")
  end 

end