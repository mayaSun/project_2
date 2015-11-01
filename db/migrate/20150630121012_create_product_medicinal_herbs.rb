class CreateProductMedicinalHerbs < ActiveRecord::Migration
  def change
    create_table :product_medicinal_herbs do |t|
      t.integer :medicinal_herb_id
      t.integer :product_id
    end
  end
end
