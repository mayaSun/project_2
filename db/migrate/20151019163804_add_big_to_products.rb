class AddBigToProducts < ActiveRecord::Migration
  def change    
    add_column :products, :medium_package_quantity, :integer
    add_column :products, :medium_package_price, :integer
    add_column :products, :big_package_quantity, :integer
    add_column :products, :big_package_price, :integer
  end
end
