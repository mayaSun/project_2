require 'spec_helper'

describe Admin::ActiveIngredientsController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @active_ingredients" do  
      get :index
      expect(assigns(:active_ingredients_1)).to eq([])
      expect(assigns(:active_ingredients_2)).to eq([])
    end

    it "devide the active ingredient well for odd numbers" do
      activity2 = Fabricate(:active_ingredient, name: 'ממריץ')
      activity1 = Fabricate(:active_ingredient, name: 'מחזק')
      activity3 = Fabricate(:active_ingredient, name: 'משלשל')
      get :index
      expect(assigns(:active_ingredients_1)).to eq([activity1, activity2])
      expect(assigns(:active_ingredients_2)).to eq([activity3])
    end

    it "devide the active ingredient well for even numbers" do      
      activity3 = Fabricate(:active_ingredient, name: 'ממריץ')
      activity2 = Fabricate(:active_ingredient, name: 'מחזק')
      activity4 = Fabricate(:active_ingredient, name: 'משלשל')
      activity1 = Fabricate(:active_ingredient, name: 'אנטי ויראלי')
      get :index
      expect(assigns(:active_ingredients_1)).to eq([activity1, activity2])
      expect(assigns(:active_ingredients_2)).to eq([activity3, activity4])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, active_ingredient: Fabricate.attributes_for(:active_ingredient)
      end

      it "create a active_ingredient" do
        expect(ActiveIngredient.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_active_ingredients_path
      end

    end

    context "with invalid input" do

      before do
        post :create, active_ingredient: Fabricate.attributes_for(:active_ingredient, name: nil)
      end

      it "dose not create active_ingredient" do
        expect(ActiveIngredient.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @active_ingredient" do
        expect(assigns(:active_ingredient)).to be_instance_of(ActiveIngredient)
      end
    end
  end

  describe 'GET edit' do

    let(:active_ingredient) {Fabricate(:active_ingredient)}
    before {
      get :edit , id: active_ingredient.slug
    }

    it "set the @active_ingredient veriable" do        
      expect(assigns[:active_ingredient]).to eq(active_ingredient)
    end

  end

  describe 'PATCH update' do

    let(:active_ingredient) { Fabricate(:active_ingredient) }

    context "with valid input" do
      before {
        patch :update, id: active_ingredient.slug ,active_ingredient: {english_name: 'New name'}
      }

      it "update the active_ingredient name" do
        expect(active_ingredient.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_active_ingredients_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: active_ingredient.slug, active_ingredient: {name: nil}
      }

      it "does not update the active_ingredient" do
        expect(ActiveIngredient.first.name).to eq(active_ingredient.name)
      end

      it "set the @active_ingredient veriable" do        
        expect(assigns[:active_ingredient]).to eq(active_ingredient)
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

    let(:active_ingredient) {Fabricate(:active_ingredient)}
    before {
      delete :destroy, id: active_ingredient.slug
    }

    it "delete the active_ingredient" do
      expect(ActiveIngredient.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_active_ingredients_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::ActiveIngredientsController do

  let(:active_ingredient) {Fabricate(:active_ingredient)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, active_ingredient: Fabricate.attributes_for(:active_ingredient)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: active_ingredient.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: active_ingredient.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: active_ingredient.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: active_ingredient.slug}
  end

end