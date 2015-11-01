class ChangeProductIdToPolymorphic < ActiveRecord::Migration
  def change
    rename_column :shopping_cart_items, :product_id, :sellable_id
    add_column :shopping_cart_items, :sellable_type, :string, after: :id
    rename_column :wishlist_items, :product_id, :sellable_id
    add_column :wishlist_items, :sellable_type, :string, after: :id
  end
end
