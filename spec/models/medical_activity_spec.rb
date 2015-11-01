
require 'spec_helper'

describe MedicalActivity do 

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:english_name) }
  it {should have_many(:medicinal_herb_medical_activities)}
  it {should have_many(:medicinal_herbs)}


  describe "search medical activity by name" do
    let(:mayami)  { Fabricate(:medical_activity, name: "Mayami")}
    let(:kalidaso)  { Fabricate(:medical_activity ,english_name: "Kalidaso")}

    it "return array of  all the product with a given name" do
      expect(MedicalActivity.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the products with a partial match" do
      expect(MedicalActivity.search_by_name("a")).to include(mayami)
      expect(MedicalActivity.search_by_name("a")).to include(kalidaso)
      expect(MedicalActivity.search_by_name("a").size).to eq(2)
    end

    it "return empty string when dosn't find products with given name" do
      expect(MedicalActivity.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(MedicalActivity.search_by_name("")).to eq([])
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:medical_activity) }
  end

end