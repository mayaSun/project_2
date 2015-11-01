class ResearchLink <ActiveRecord::Base
  
  validates_presence_of :medicinal_herb ,:url
  belongs_to :medicinal_herb

end