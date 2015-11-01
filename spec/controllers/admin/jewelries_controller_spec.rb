require 'spec_helper'

describe Admin::JewelriesController do

  valid_jewelry_crystals_params = {
    "0"=>{price:"100", crystal_id:"4"},
    "1"=>{price:"200", crystal_id:"7"},
    "2"=>{price:"20", crystal_id:"8"},
    "3"=>{price:"20", crystal_id:"9"},
    "4"=>{price:"20", crystal_id:"10"},
    "5"=>{price:"20", crystal_id:"11"},
    "6"=>{price:"20", crystal_id:"12"},
    "7"=>{price:"111", crystal_id:"6"},
    "8"=>{price:"1", crystal_id:"13"},
    "9"=>{price:"2", crystal_id:"14"},
    "10"=>{price:"2000", crystal_id:"15"},
    "11"=>{price:"20", crystal_id:"16"},
    "12"=>{price:"20", crystal_id:"17"},
    "13"=>{price:"20", crystal_id:"18"},
    "14"=>{price:"", crystal_id:""},
    "15"=>{price:"", crystal_id:""},
    "16"=>{price:"", crystal_id:""},
    "17"=>{price:"", crystal_id:""},
    "18"=>{price:"", crystal_id:""}}

  not_valid_jewelry_crystals_params = {
    "0"=>{price:"100", crystal_id:"4"},
    "1"=>{price:"200", crystal_id:"7"},
    "2"=>{price:"20", crystal_id:"8"},
    "3"=>{price:"20", crystal_id:"9"},
    "4"=>{price:"20", crystal_id:"10"},
    "5"=>{price:"20", crystal_id:"13"},
    "6"=>{price:"20", crystal_id:"12"},
    "7"=>{price:"111", crystal_id:"6"},
    "8"=>{price:"1", crystal_id:"13"},
    "9"=>{price:"2", crystal_id:"14"},
    "10"=>{price:"2000", crystal_id:"15"},
    "11"=>{price:"20", crystal_id:"16"},
    "12"=>{price:"20", crystal_id:"17"},
    "13"=>{price:"20", crystal_id:"18"},
    "14"=>{price:"", crystal_id:""},
    "15"=>{price:"", crystal_id:""},
    "16"=>{price:"", crystal_id:""},
    "17"=>{price:"", crystal_id:""},
    "18"=>{price:"", crystal_id:""}}

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @jewelries" do      
      get :index
      expect(assigns(:jewelries)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, jewelry: Fabricate.attributes_for(:jewelry).merge!(jewelry_crystals: valid_jewelry_crystals_params)
      end

      it "create a Jewelry" do
        expect(Jewelry.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_jewelries_path
      end

    end

    context "with invalid input" do

      before do
        post :create, jewelry: Fabricate.attributes_for(:jewelry, name: nil).merge!(jewelry_crystals: valid_jewelry_crystals_params)
      end

      it "dose not create Jewelry" do
        expect(Jewelry.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @jewelry" do
        expect(assigns(:jewelry)).to be_instance_of(Jewelry)
      end
    end

    context "with invalid jewelry_crystals input" do

      before do
        post :create, jewelry: Fabricate.attributes_for(:jewelry).merge!(jewelry_crystals: not_valid_jewelry_crystals_params)
      end

      it "dose not create Jewelry" do
        expect(Jewelry.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @jewelry" do
        expect(assigns(:jewelry)).to be_instance_of(Jewelry)
      end
    end
  end

  describe 'GET edit' do

    let(:jewelry) {Fabricate(:jewelry)}
    before {
      get :edit , id: jewelry.slug
    }

    it "set the @jewelry veriable" do        
      expect(assigns[:jewelry]).to eq(jewelry)
    end

  end

  describe 'PATCH update' do

    let(:jewelry) { Fabricate(:jewelry) }

    context "with valid input" do
      before {
        patch :update, id: jewelry.slug ,jewelry: {english_name: 'New name'}.merge!(jewelry_crystals: valid_jewelry_crystals_params)
      }

      it "update the Jewelry name" do
        expect(jewelry.reload.english_name).to eq('New name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_jewelries_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: jewelry.slug, jewelry: {name: nil}.merge!(jewelry_crystals: valid_jewelry_crystals_params)
      }

      it "does not update the Jewelry" do
        expect(Jewelry.first.name).to eq(jewelry.name)
      end

      it "set the @jewelry veriable" do        
        expect(assigns[:jewelry]).to eq(jewelry)
      end

      it "render edit" do
        expect(response).to render_template :edit
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end

    context "with invalid jewelry_crystals input" do

      before {
        patch :update, id: jewelry.slug, jewelry: { jewelry_crystals: not_valid_jewelry_crystals_params }
      }

      it "does not update the Jewelry" do
        expect(Jewelry.first.jewelry_crystals).to eq(jewelry.jewelry_crystals)
      end

      it "set the @jewelry veriable" do        
        expect(assigns[:jewelry]).to eq(jewelry)
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

    let(:jewelry) {Fabricate(:jewelry)}
    before {
      delete :destroy, id: jewelry.slug
    }

    it "delete the Jewelry" do
      expect(Jewelry.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_jewelries_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end


  describe 'DELETE destroy' do

    let(:jewelry) {Fabricate(:jewelry)}
    before {
      delete :destroy, id: jewelry.slug
    }

    it "delete the Jewelry" do
      expect(Jewelry.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_jewelries_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::JewelriesController do

  let(:jewelry) {Fabricate(:jewelry)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, Jewelry: Fabricate.attributes_for(:jewelry)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: jewelry.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: jewelry.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: jewelry.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: jewelry.slug}
  end

end