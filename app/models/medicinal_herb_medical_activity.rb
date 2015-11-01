class MedicinalHerbMedicalActivity <ActiveRecord::Base  
  
  validates_presence_of :medicinal_herb ,:medical_activity
  
  belongs_to :medicinal_herb
  belongs_to :medical_activity

end
