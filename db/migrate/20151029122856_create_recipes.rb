class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :text
      t.string :image
      t.string :slug
      t.timestamps
    end
  end
end
