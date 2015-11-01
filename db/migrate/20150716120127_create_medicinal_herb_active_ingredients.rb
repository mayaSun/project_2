class CreateMedicinalHerbActiveIngredients < ActiveRecord::Migration
  def change
    create_table :medicinal_herb_active_ingredients do |t|
      t.integer :medicinal_herb_id
      t.integer :active_ingredient_id
    end
  end
end
