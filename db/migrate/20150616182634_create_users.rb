class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role, :default => 'customer'
      t.string :slug
      t.timestamps
    end
  end
end
