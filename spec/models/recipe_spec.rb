require 'spec_helper'

describe Recipe do 

  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:text)}

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:recipe) }
  end

end