require 'spec_helper'

describe MedicinalHerbMedicalActivity do

  it {should validate_presence_of(:medical_activity)}
  it {should validate_presence_of(:medicinal_herb)}

  it {should belong_to(:medical_activity)}
  it {should belong_to(:medicinal_herb)}

end