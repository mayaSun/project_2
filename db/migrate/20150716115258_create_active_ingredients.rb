class CreateActiveIngredients < ActiveRecord::Migration
  def change
    create_table :active_ingredients do |t|
      t.string :name
      t.string :english_name
      t.text :description
      t.string :slug
    end
  end
end
