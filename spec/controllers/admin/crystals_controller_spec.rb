require 'spec_helper'

describe Admin::CrystalsController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @crystals" do      
      get :index
      expect(assigns(:crystals)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, crystal: Fabricate.attributes_for(:crystal)
      end

      it "create a crystal" do
        expect(Crystal.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_crystals_path
      end

    end

    context "with invalid input" do

      before do
        post :create, crystal: Fabricate.attributes_for(:crystal, name: nil)
      end

      it "dose not create crystal" do
        expect(Crystal.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @crystal" do
        expect(assigns(:crystal)).to be_instance_of(Crystal)
      end
    end
  end

  describe 'GET edit' do

    let(:crystal) {Fabricate(:crystal)}
    before {
      get :edit , id: crystal.slug
    }

    it "set the @crystal veriable" do        
      expect(assigns[:crystal]).to eq(crystal)
    end

  end

  describe 'PATCH update' do

    let(:crystal) { Fabricate(:crystal) }

    context "with valid input" do
      before {
        patch :update, id: crystal.slug ,crystal: {english_name: 'New name'}
      }

      it "update the crystal name" do
        expect(crystal.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_crystals_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: crystal.slug, crystal: {name: nil}
      }

      it "does not update the crystal" do
        expect(Crystal.first.name).to eq(crystal.name)
      end

      it "set the @crystal veriable" do        
        expect(assigns[:crystal]).to eq(crystal)
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

    let(:crystal) {Fabricate(:crystal)}
    before {
      delete :destroy, id: crystal.slug
    }

    it "delete the crystal" do
      expect(Crystal.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_crystals_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

  describe 'DELETE destroy' do

    let(:crystal) {Fabricate(:crystal)}
    before {
      delete :destroy, id: crystal.slug
    }

    it "delete the crystal" do
      expect(Crystal.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_crystals_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::CrystalsController do

  let(:crystal) {Fabricate(:crystal)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, crystal: Fabricate.attributes_for(:crystal)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: crystal.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: crystal.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: crystal.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: crystal.slug}
  end

end