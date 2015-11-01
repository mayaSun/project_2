require 'spec_helper'

describe Product do 

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:english_name)}
  it {should validate_presence_of(:short_description)}
  it {should validate_presence_of(:category)}
  it {should validate_presence_of(:price)}
  it {should validate_presence_of(:image)}
  it {should validate_presence_of(:quantity)}
  it {should validate_presence_of(:quantity_unit)}
  
  it {should validate_numericality_of(:stock)}
  it {should validate_numericality_of(:price)}
  it {should validate_numericality_of(:quantity)}
  it {should validate_numericality_of(:package_weight)}

  it {should belong_to(:category)}
  it {should have_many(:shopping_cart_items)}
  it {should have_many(:wishlist_items)}
  it {should have_many(:product_medicinal_herbs)}
  it {should have_many(:medicinal_herbs)}


  describe "search product by name" do
    let(:mayami)  { Fabricate(:product, name: "Mayami")}
    let(:kalidaso)  { Fabricate(:product,english_name: "Kalidaso")}

    it "return array of  all the product with a given name" do
      expect(Product.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the products with a partial match" do
      expect(Product.search_by_name("a")).to include(mayami)
      expect(Product.search_by_name("a")).to include(kalidaso)
      expect(Product.search_by_name("a").size).to eq(2)
    end

    it "return empty string when dosn't find products with given name" do
      expect(Product.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(Product.search_by_name("")).to eq([])
    end
  end

  describe '#check_nutritional_data' do
    
    let!(:product) { Fabricate(:product, energy: '245', carbohydrates: '567.2' ,protein: '56' ,fat: '56.2' ,saturated_fat: '5.23' ,cholesterol: '54' ,sodium: '0') }
    
    it "set product with all nutritional data" do
      expect(Product.count).to eq(1)
    end

    it "validate energy is set" do
      expect(product.update(energy: nil)).to eq(false)
    end   
      
    it "validate carbohydrates is set" do  
      expect(product.update(carbohydrates: nil)).to eq(false)
    end
    
    it "validate protein is set" do  
      expect(product.update(protein: nil)).to eq(false)
    end

    it "validate fat is set" do  
      expect(product.update(fat: nil)).to eq(false)
    end

    it "validate saturated_fat is set" do  
      expect(product.update(saturated_fat: nil)).to eq(false)
    end

    it "validate cholesterol is set" do  
      expect(product.update(cholesterol: nil)).to eq(false)
    end

    it "validate sodium is set" do  
      expect(product.update(sodium: nil)).to eq(false)
    end
  
  end

  describe "#is_food?" do
    it "return true if is't food" do
      product = Fabricate(:product, energy: '245', carbohydrates: '567.2' ,protein: '56' ,fat: '56.2' ,saturated_fat: '5.23' ,cholesterol: '54' ,sodium: '0')     
      expect(product.is_food?).to eq(true)
    end
    
    it "return false if is't not food" do
      product = Fabricate(:product)
      expect(product.is_food?).to eq(false)
    end
  end

  describe "#orders" do
    it "return the orders contained the product" do
      product = Fabricate(:product)
      other_product = Fabricate(:product)
      order1 = ShoppingCartItem.create(sellable: product, position: Fabricate(:order), qty: 1)
      order2 = ShoppingCartItem.create(sellable: other_product, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: product, position: Fabricate(:order), qty: 1)
      expect(product.orders.count).to eq(2)
      expect(product.orders).to include(order1)
      expect(product.orders).to include(order3)
      expect(product.orders).to_not include(order2)
    end

    it "return [] if there is no orders" do
      product = Fabricate(:product)
      other_product = Fabricate(:product)
      ShoppingCartItem.create(sellable: other_product, position: Fabricate(:order), qty: 1)
      expect(product.orders).to eq([])
    end
  end

  describe "#last_ordered" do
    it "return the last order date of the product" do
      product = Fabricate(:product)
      other_product = Fabricate(:product)
      order1 = ShoppingCartItem.create(sellable: product, position: Fabricate(:order), qty: 1, updated_at: 1.days.ago)
      order2 = ShoppingCartItem.create(sellable: other_product, position: Fabricate(:order), qty: 1)
      order3 = ShoppingCartItem.create(sellable: product, position: Fabricate(:order), qty: 1, updated_at: 3.days.ago)
      expect(product.last_ordered.to_formatted_s(:short) ).to eq(order1.updated_at.to_formatted_s(:short))
    end
  end

  describe "#medicinal_herbs_text" do
    it "return a texts with the names of all medicinal herbs" do
      medicinal_herb1 = Fabricate(:medicinal_herb)
      medicinal_herb2 = Fabricate(:medicinal_herb)
      product = Fabricate(:product, medicinal_herbs: [medicinal_herb1, medicinal_herb2])
      expect(product.medicinal_herbs_text).to  include(medicinal_herb1.name) 
      expect(product.medicinal_herbs_text).to  include(medicinal_herb2.name)
    end

    it "return empty string if there are no medicinal herbs" do
      product = Fabricate(:product)
      expect(product.medicinal_herbs_text).to  eq('') 
    end
  end

  it_behaves_like "slugable" do
    let(:object) { Fabricate(:product) }
  end

end