require 'spec_helper'

describe ProductMedicinalHerb do

  it {should validate_presence_of(:product)}
  it {should validate_presence_of(:medicinal_herb)}

  it {should belong_to(:product)}
  it {should belong_to(:medicinal_herb)}

end