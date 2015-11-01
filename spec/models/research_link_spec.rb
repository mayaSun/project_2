require 'spec_helper'

describe ResearchLink do 

  it {should validate_presence_of(:url)}
  it {should validate_presence_of(:medicinal_herb)}
  it {should belong_to(:medicinal_herb)}

end