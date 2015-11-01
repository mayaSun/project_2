class CreateMedicinalHerbs < ActiveRecord::Migration
  def change
    create_table :medicinal_herbs do |t|
      t.string :name
      t.string :english_name
      t.string :latin_name
      t.text   :description
      t.text   :medicinal_properties
      t.text   :use_instructions
      t.text   :warnings
      t.string :image
      t.string :sprout_image
      t.string :other_qualities
      t.string :slug
    end
  end
end
