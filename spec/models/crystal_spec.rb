require 'spec_helper'

describe Crystal do 

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:english_name)}
  #it {should validate_presence_of(:image)}


  describe "search crystal by name" do
    let(:mayami)  { Fabricate(:crystal, name: "Mayami")}
    let(:kalidaso)  { Fabricate(:crystal,name: "Kalidaso")}

    it "return array of  all the crystal with a given name" do
      expect(Crystal.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the crystals with a partial match" do
      expect(Crystal.search_by_name("a")).to include(mayami)
      expect(Crystal.search_by_name("a")).to include(kalidaso)
      expect(Crystal.search_by_name("a").size).to eq(2)
    end

    it "return empty string when dosn't find crystals with given name" do
      expect(Crystal.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(Crystal.search_by_name("")).to eq([])
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:crystal) }
  end

  it_behaves_like "prev_next" do
    let(:object) { Fabricate(:crystal) }
    let(:object_fabricator) {"crystal"}
  end

end