class Category <ActiveRecord::Base
  include Sluggable
  sluggable_column :english_name
  mount_uploader :image, CategoryImageUploader

  has_many :products 
  validates_presence_of :name , :english_name

  belongs_to :category
  has_many :categories

  before_save :capitalize_name

  def capitalize_name
    self.english_name = self.english_name.titleize
  end

  def self.non_sub_categories
    Category.where(category_id: nil)
  end

end