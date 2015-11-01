require 'spec_helper'

describe WishlistItem do
  it {should belong_to(:user)}
  it {should belong_to(:sellable)}
  it {should validate_presence_of(:sellable)}
  it {should validate_presence_of(:user)}

  it {should respond_to(:name)}
  it {should respond_to(:image)}
  it {should respond_to(:price)}
end