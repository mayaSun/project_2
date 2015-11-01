class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :english_name
      t.text :description
      t.string :image
      t.string :slug
      t.integer :category_id
    end
  end
end
