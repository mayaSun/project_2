class CreateMedicalActivities < ActiveRecord::Migration
  def change
    create_table :medical_activities do |t|
      t.string :name
      t.string :english_name
      t.text :description
      t.string :slug
    end
  end
end
