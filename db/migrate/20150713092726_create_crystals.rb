class CreateCrystals < ActiveRecord::Migration
  def change
    create_table :crystals do |t|
      t.string :name
      t.string :english_name
      t.integer :price
      t.string :chemical_formula
      t.string :image
      t.string :hardness
      t.text   :qualities
      t.text   :use_instructions
      t.text   :warnings
      t.string :slug
    end
  end
end
