class CreateResearchLinks < ActiveRecord::Migration
  def change
    create_table :research_links do |t|
      t.integer :medicinal_herb_id
      t.string :url
    end
  end
end
