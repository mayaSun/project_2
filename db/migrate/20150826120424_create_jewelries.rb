class CreateJewelries < ActiveRecord::Migration
  def change
    create_table :jewelries do |t|
      t.string :name
      t.string :english_name
      t.text :long_description
      t.float :price
      t.integer :crystal_id    
      t.string :image
      t.string :slug
      t.timestamps      
    end
  end
end
