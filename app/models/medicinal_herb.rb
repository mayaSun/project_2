class MedicinalHerb <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name
  
  include PrevNext  

  validates_presence_of :name ,:english_name
  mount_uploader :image, MedicinalHerbImageUploader
  mount_uploader :sprout_image, SproutMedicinalHerbImageUploader

  has_many :product_medicinal_herbs
  has_many :products, through: :product_medicinal_herbs

  has_many :medicinal_herb_medical_activities
  has_many :medical_activities, through: :medicinal_herb_medical_activities

  has_many :medicinal_herb_active_ingredients
  has_many :active_ingredients, through: :medicinal_herb_active_ingredients

  has_many :research_links

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    MedicinalHerb.where("name ILIKE ? OR english_name ILIKE ? OR latin_name ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%") 
  end 


  def validate_research_links_data(params = {})
    links_array = params.map{|o| o[1]}.delete_if{|x| !x[:url] || x[:url].length < 2}.uniq
    links_array.each_with_index do |link, index|              
      if !link[:url].start_with?("http://") && !link[:url].start_with?("https://")
        return 'Link must start with http://, please copy&past from browser'  
      end
    end
    return true
  end

  def set_research_links_data(params = {})
    links_array = params.map{|o| o[1]}.delete_if{|x| !x[:url] || x[:url].length < 2}.uniq
    size = research_links.count
    links_array.each_with_index do |link, index|
      if index < size
        research_links[index].update(url: link[:url])
      else
        research_links.create(url: link[:url])
      end
    end
    if  links_array.size < size
      (links_array.size..size-1).each do |deleted_index| 
        research_links[deleted_index].delete   
      end
    end
  end


end
