class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :english_name
      t.text :short_description
      t.text :long_description
      t.text :use_instructions
      t.text :ingridience
      t.text :warnings
      t.float :price
      t.integer :stock
      t.integer :category_id      
      t.string :image
      t.integer :quantity
      t.string :quantity_unit
      t.integer :package_weight
      # Nutritional Data 
      t.float :energy
      t.float :carbohydrates
      t.float :protein
      t.float :fat
      t.float :saturated_fat
      t.float :cholesterol
      t.float :sodium
      t.text :other_nutrients
      t.string :slug
      t.timestamps
    end
  end
end
