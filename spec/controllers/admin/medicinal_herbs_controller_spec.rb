require 'spec_helper'

describe Admin::MedicinalHerbsController do

  valid_research_links_params = {
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

  not_valid_research_links_params = {
    "0"=>{url:"https://umm.edu/health/medical/altmed/herb/lavender"},
    "1"=>{url:"http://www.medicalnewstoday.com/articles/265922.php"},
    "2"=>{url:"ttp://www.hindawi.com/journals/ecam/2013/681304/"},
    "3"=>{url:"https://www.nlm.nih.gov/medlineplus/druginfo/natural/838.html"},
    "4"=>{url:"https://nccih.nih.gov/health/lavender/ataglance.htm"},
    "5"=>{url:""},
    "6"=>{url:""},
    "7"=>{url:""},
    "8"=>{url:""},
    "9"=>{url:""}}


  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @medicinal_herbs" do  
      get :index
      expect(assigns(:medicinal_herbs)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, medicinal_herb: Fabricate.attributes_for(:medicinal_herb).merge!(research_links: valid_research_links_params)
      end

      it "create a medicinal_herb" do
        expect(MedicinalHerb.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_medicinal_herbs_path
      end

    end

    context "with invalid input" do

      before do
        post :create, medicinal_herb: Fabricate.attributes_for(:medicinal_herb, name: nil).merge!(research_links: valid_research_links_params)
      end

      it "dose not create medicinal_herb" do
        expect(MedicinalHerb.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @medicinal_herb" do
        expect(assigns(:medicinal_herb)).to be_instance_of(MedicinalHerb)
      end
    end

    context "with invalid research_links input" do

      before do
        post :create, medicinal_herb: Fabricate.attributes_for(:medicinal_herb).merge!(research_links: not_valid_research_links_params)
      end

      it "dose not create MedicinalHerb" do
        expect(MedicinalHerb.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @medicinal_herb" do
        expect(assigns(:medicinal_herb)).to be_instance_of(MedicinalHerb)
      end
    end

  end

  describe 'GET edit' do

    let(:medicinal_herb) {Fabricate(:medicinal_herb)}
    before {
      get :edit , id: medicinal_herb.slug
    }

    it "set the @medicinal_herb veriable" do        
      expect(assigns[:medicinal_herb]).to eq(medicinal_herb)
    end

  end

  describe 'PATCH update' do

    let(:medicinal_herb) { Fabricate(:medicinal_herb) }

    context "with valid input" do
      before {
        patch :update, id: medicinal_herb.slug ,medicinal_herb: {english_name: 'New name'}.merge!(research_links: valid_research_links_params)
      }

      it "update the medicinal_herb name" do
        expect(medicinal_herb.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_medicinal_herbs_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: medicinal_herb.slug, medicinal_herb: {name: nil}.merge!(research_links: valid_research_links_params)
      }

      it "does not update the medicinal_herb" do
        expect(MedicinalHerb.first.name).to eq(medicinal_herb.name)
      end

      it "set the @medicinal_herb veriable" do        
        expect(assigns[:medicinal_herb]).to eq(medicinal_herb)
      end

      it "render edit" do
        expect(response).to render_template :edit
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end

    context "with invalid research_links input" do

      before {
        patch :update, id: medicinal_herb.slug, medicinal_herb: {name: 'new'}.merge!(research_links: not_valid_research_links_params)
      }

      it "does not update the medicinal_herb" do
        expect(MedicinalHerb.first.research_links).to eq(medicinal_herb.research_links)
      end

      it "set the @medicinal_herb veriable" do        
        expect(assigns[:medicinal_herb]).to eq(medicinal_herb)
      end

      it "render edit" do
        expect(response).to render_template :edit
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end

  end


  describe 'DELETE destroy' do

    let(:medicinal_herb) {Fabricate(:medicinal_herb)}
    before {
      delete :destroy, id: medicinal_herb.slug
    }

    it "delete the medicinal_herb" do
      expect(MedicinalHerb.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_medicinal_herbs_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::MedicinalHerbsController do

  let(:medicinal_herb) {Fabricate(:medicinal_herb)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, medicinal_herb: Fabricate.attributes_for(:medicinal_herb)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: medicinal_herb.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: medicinal_herb.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: medicinal_herb.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: medicinal_herb.slug}
  end

end