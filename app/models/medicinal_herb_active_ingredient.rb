class MedicinalHerbActiveIngredient <ActiveRecord::Base
  
  validates_presence_of :medicinal_herb ,:active_ingredient
  
  belongs_to :medicinal_herb
  belongs_to :active_ingredient

end
