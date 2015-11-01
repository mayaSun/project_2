class CreateJewelryCrystals < ActiveRecord::Migration
  def change
    create_table :jewelry_crystals do |t|
      t.integer :jewelry_id
      t.integer :crystal_id
      t.integer :price
    end
  end
end
