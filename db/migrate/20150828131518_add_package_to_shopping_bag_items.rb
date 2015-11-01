class AddPackageToShoppingBagItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :package_type, :string
  end
end
