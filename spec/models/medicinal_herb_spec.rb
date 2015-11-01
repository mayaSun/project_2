require 'spec_helper'

describe MedicinalHerb do 


  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:english_name)}

  it {should have_many(:product_medicinal_herbs)}
  it {should have_many(:products)}
  it {should have_many(:medicinal_herb_medical_activities)}
  it {should have_many(:medical_activities)}
  it {should have_many(:medicinal_herb_active_ingredients)}
  it {should have_many(:active_ingredients)}
  it {should have_many(:research_links)}

  describe "search product by name" do
    let(:mayami)  { Fabricate(:medicinal_herb, name: "Mayami")}
    let(:kalidaso)  { Fabricate(:medicinal_herb ,english_name: "Kalidaso")}
    let(:latino)  { Fabricate(:medicinal_herb ,latin_name: "latino")}

    it "return array of  all the product with a given name" do
      expect(MedicinalHerb.search_by_name("Mayami")).to eq([mayami])
    end

    it "return array of  all the products with a partial match" do
      expect(MedicinalHerb.search_by_name("a")).to include(mayami)
      expect(MedicinalHerb.search_by_name("a")).to include(kalidaso)
      expect(MedicinalHerb.search_by_name("a")).to include(latino)
      expect(MedicinalHerb.search_by_name("a").size).to eq(3)
    end

    it "return empty string when dosn't find products with given name" do
      expect(MedicinalHerb.search_by_name("q").size).to eq(0)
    end

    it "return array string when search_term is empty string" do
      expect(MedicinalHerb.search_by_name("")).to eq([])
    end
  end

  describe "#validate_research_links_data" do
    let(:medicinal_herb)  { Fabricate(:medicinal_herb) }
    it "return true for valid params" do
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:"https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html"},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
        expect(medicinal_herb.validate_research_links_data(params)).to eq(true)
    end

    it "return true for empty params" do
      params = {
        "0"=>{url:""},
        "1"=>{url:""},
        "2"=>{url:""},
        "3"=>{url:""},
        "4"=>{url:""},
        "5"=>{url: nil}}
        expect(medicinal_herb.validate_research_links_data(params)).to eq(true)
    end

    it "return error for bad url" do
      params = {
        "0"=>{url:"ttps://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:"https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html"},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
        expect(medicinal_herb.validate_research_links_data(params)).to eq('Link must start with http://, please copy&past from browser')
    end
  end

  describe "#set_medicinal_herb_data" do
    let!(:medicinal_herb) {Fabricate(:medicinal_herb)}

    it "set all medicinal_herb links for new record" do
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:"https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html"},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
      medicinal_herb.set_research_links_data(params)
      expect(medicinal_herb.research_links.map{ |x| x[:url]}).to eq(["https://umm.edu/health/medical/altmed/herb/lavender", "http://www.medicalnewstoday.com/articles/265922.php", "http://www.hindawi.com/journals/ecam/2013/681304/", "https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html", "https://nccih.nih.gov/health/lavender/ataglance.htm"])   
    end

    it "update the data of exist medicinal_herb links" do
      medicinal_herb.research_links.create(url: "http://oilsisrael.com/product-category/aromatic-oils/page/4/")
      medicinal_herb.research_links.create(url: "https://www.cherylsherbs.com/home/")
      medicinal_herb.research_links.create(url: "http://store.theherbalist.com/pages/products")
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:"https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html"},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
      medicinal_herb.set_research_links_data(params)  
      expect(medicinal_herb.research_links.map{ |x| x[:url]}).to eq(["https://umm.edu/health/medical/altmed/herb/lavender", "http://www.medicalnewstoday.com/articles/265922.php", "http://www.hindawi.com/journals/ecam/2013/681304/", "https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html", "https://nccih.nih.gov/health/lavender/ataglance.htm"])    
    end

    it "delete data" do
      medicinal_herb.research_links.create(url: "http://oilsisrael.com/product-category/aromatic-oils/page/4/")
      medicinal_herb.research_links.create(url: "https://www.cherylsherbs.com/home/")
      medicinal_herb.research_links.create(url: "http://store.theherbalist.com/pages/products")
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:""},
        "3"=>{url:""},
        "4"=>{url:""},
        "5"=>{url:""},
        "6"=>{url:""}}
      medicinal_herb.set_research_links_data(params)  
      expect(medicinal_herb.reload.research_links.map{ |x| x[:url]}).to eq(["https://umm.edu/health/medical/altmed/herb/lavender", "http://www.medicalnewstoday.com/articles/265922.php"])    
    end       

    it "ignore empty data" do
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:""},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
      medicinal_herb.set_research_links_data(params)  
      expect(medicinal_herb.research_links.map{ |x| x[:url]}).to eq(["https://umm.edu/health/medical/altmed/herb/lavender", "http://www.medicalnewstoday.com/articles/265922.php", "http://www.hindawi.com/journals/ecam/2013/681304/", "https://nccih.nih.gov/health/lavender/ataglance.htm"])        
    end

    it "ignore multiple link" do
      params = {
        "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
        "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "2"=>{url:"http://www.hindawi.com/journals/ecam/2013/681304/"},
        "3"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
        "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
        "5"=>{url:""},
        "6"=>{url:""},
        "7"=>{url:""},
        "8"=>{url:""},
        "9"=>{url:""}}
      medicinal_herb.set_research_links_data(params)  
      expect(medicinal_herb.research_links.map{ |x| x[:url]}).to eq(["https://umm.edu/health/medical/altmed/herb/lavender", "http://www.medicalnewstoday.com/articles/265922.php", "http://www.hindawi.com/journals/ecam/2013/681304/", "https://nccih.nih.gov/health/lavender/ataglance.htm"])        
    end


  end

























  it_behaves_like "slugable" do
    let(:object) { Fabricate(:medicinal_herb) }
  end

  it_behaves_like "prev_next" do
    let(:object) { Fabricate(:medicinal_herb) }
    let(:object_fabricator) {"medicinal_herb"}
  end

end