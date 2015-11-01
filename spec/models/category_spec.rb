require 'spec_helper'

describe Category do 

  it {should have_many(:products)}
  it { should validate_presence_of(:name) }

  describe "non sub category" do

    let!(:brass) { Fabricate(:category, name: "brass")}
    let!(:silver) { Fabricate(:category, name: "silver", category: brass)}

    it "return array of all categories without sub categiories" do
      expect(Category.non_sub_categories).to eq([brass])
    end

  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:category) }
  end

end