class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.string :delivery_method
      t.integer :shipping_address_id
      t.integer :billing_address_id
      t.integer :user_id
      t.string :reference_id
      t.string :confirmation_number
      t.string :tracking_number
      t.string :slug
      t.timestamps
    end
  end
end
