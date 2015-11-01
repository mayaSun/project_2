class Recipe <ActiveRecord::Base
  include Sluggable
  sluggable_column :slug_column
  mount_uploader :image, RecipeImageUploader

  validates_presence_of :title ,:text

  def slug_column
    Array.new(8){[*"A".."Z", *"0".."9"].sample}.join
  end

end