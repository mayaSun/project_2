class AddImageLinkToCrystals < ActiveRecord::Migration
  def change
    add_column :crystals, :image_link, :string
  end
end
