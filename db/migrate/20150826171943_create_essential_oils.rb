class CreateEssentialOils < ActiveRecord::Migration
  def change
    create_table :essential_oils do |t|
      t.string :name
      t.string :english_name
      t.text :use_instructions
      t.text :warnings
      t.integer :price_5ml 
      t.integer :price_10ml
      t.integer :price_50ml    
      t.string :image
      t.string :slug      
      t.timestamps
    end
  end
end
