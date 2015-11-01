class ProductMedicinalHerb <ActiveRecord::Base

  validates_presence_of :product ,:medicinal_herb
  
  belongs_to :product
  belongs_to :medicinal_herb

end