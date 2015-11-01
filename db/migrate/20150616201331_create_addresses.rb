class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :country_code
      t.string :state_code
      t.string :postal_code
      t.string :phone_number
      t.string :email
      t.string :status
      t.boolean :billing
      t.boolean :shipping
      t.integer :user_id
      t.string :slug
    end
  end
end

