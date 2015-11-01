class CreateMedicinalHerbMedicalActivities < ActiveRecord::Migration
  def change
    create_table :medicinal_herb_medical_activities do |t|
      t.integer :medicinal_herb_id
      t.integer :medical_activity_id
    end
  end
end
