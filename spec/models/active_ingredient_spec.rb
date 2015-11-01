
require 'spec_helper'

describe ActiveIngredient do 

  it {should have_many(:medicinal_herbs)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:english_name) }
  it {should have_many(:medicinal_herb_active_ingredients)}
  it {should have_many(:medicinal_herbs)}


  describe "search Active Ingredient by name" do
    let(:mayami)  { Fabricate(:active_ingredient, name: "Mayami")}
    let(:kalidaso)  { Fabricate(:active_ingredient ,english_name: "Kalidaso")}

    it "return array of  all the product with a given name" do
      expect(ActiveIngredient.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the products with a partial match" do
      expect(ActiveIngredient.search_by_name("a")).to include(mayami)
      expect(ActiveIngredient.search_by_name("a")).to include(kalidaso)
      expect(ActiveIngredient.search_by_name("a").size).to eq(2)
    end

    it "return empty string when dosn't find products with given name" do
      expect(ActiveIngredient.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(ActiveIngredient.search_by_name("")).to eq([])
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:active_ingredient) }
  end

end