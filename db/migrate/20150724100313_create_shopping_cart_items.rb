class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.integer :product_id
      t.references :position, polymorphic: true, index: true
      t.integer :qty
      t.timestamps
    end
  end
end
