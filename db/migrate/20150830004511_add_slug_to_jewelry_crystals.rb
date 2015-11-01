class AddSlugToJewelryCrystals < ActiveRecord::Migration
  def change
    add_column :jewelry_crystals, :slug, :string
  end
end
