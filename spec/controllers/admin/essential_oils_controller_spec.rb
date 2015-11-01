require 'spec_helper'

describe Admin::EssentialOilsController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @essential_oils" do      
      get :index
      expect(assigns(:essential_oils)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, essential_oil: Fabricate.attributes_for(:essential_oil)
      end

      it "create a essential_oil" do
        expect(EssentialOil.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_essential_oils_path
      end

    end

    context "with invalid input" do

      before do
        post :create, essential_oil: Fabricate.attributes_for(:essential_oil, name: nil)
      end

      it "dose not create essential_oil" do
        expect(EssentialOil.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @essential_oil" do
        expect(assigns(:essential_oil)).to be_instance_of(EssentialOil)
      end
    end
  end

  describe 'GET edit' do

    let(:essential_oil) {Fabricate(:essential_oil)}
    before {
      get :edit , id: essential_oil.slug
    }

    it "set the @essential_oil veriable" do        
      expect(assigns[:essential_oil]).to eq(essential_oil)
    end

  end

  describe 'PATCH update' do

    let(:essential_oil) { Fabricate(:essential_oil) }

    context "with valid input" do
      before {
        patch :update, id: essential_oil.slug ,essential_oil: {english_name: 'New name'}
      }

      it "update the essential_oil name" do
        expect(essential_oil.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_essential_oils_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: essential_oil.slug, essential_oil: {name: nil}
      }

      it "does not update the essential_oil" do
        expect(EssentialOil.first.name).to eq(essential_oil.name)
      end

      it "set the @essential_oil veriable" do        
        expect(assigns[:essential_oil]).to eq(essential_oil)
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

    let(:essential_oil) {Fabricate(:essential_oil)}
    before {
      delete :destroy, id: essential_oil.slug
    }

    it "delete the essential_oil" do
      expect(EssentialOil.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_essential_oils_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end


  describe 'DELETE destroy' do

    let(:essential_oil) {Fabricate(:essential_oil)}
    before {
      delete :destroy, id: essential_oil.slug
    }

    it "delete the essential_oil" do
      expect(EssentialOil.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_essential_oils_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::EssentialOilsController do

  let(:essential_oil) {Fabricate(:essential_oil)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, essential_oil: Fabricate.attributes_for(:essential_oil)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: essential_oil.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: essential_oil.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: essential_oil.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: essential_oil.slug}
  end

end