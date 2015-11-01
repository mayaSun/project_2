class CreateFreePlantsOrders < ActiveRecord::Migration
  def change
    create_table :free_plants_orders do |t|
      t.integer :address_id
      t.string :plant_1
      t.string :plant_2
      t.string :delivery_method
      t.timestamps
    end
  end
end
