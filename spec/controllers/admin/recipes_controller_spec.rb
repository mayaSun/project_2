require 'spec_helper'

describe Admin::RecipesController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @recipes" do      
      get :index
      expect(assigns(:recipes)).to eq([])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, recipe: Fabricate.attributes_for(:recipe)
      end

      it "create a Recipe" do
        expect(Recipe.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_recipes_path
      end

    end

    context "with invalid input" do

      before do
        post :create, recipe: Fabricate.attributes_for(:recipe, title: nil)
      end

      it "dose not create recipe" do
        expect(Recipe.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @recipe" do
        expect(assigns(:recipe)).to be_instance_of(Recipe)
      end
    end
  end

  describe 'GET edit' do

    let(:recipe) {Fabricate(:recipe)}
    before {
      get :edit , id: recipe.slug
    }

    it "set the @recipe veriable" do        
      expect(assigns[:recipe]).to eq(recipe)
    end

  end

  describe 'PATCH update' do

    let(:recipe) { Fabricate(:recipe) }

    context "with valid input" do
      before {
        patch :update, id: recipe.slug ,recipe: {title: 'New name'}
      }

      it "update the recipe name" do
        expect(recipe.reload.title).to eq('New name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_recipes_path
      end

    end

    context "with invalid input" do
      before {
        patch :update, id: recipe.slug, recipe: {title: nil}
      }

      it "does not update the recipe" do
        expect(Recipe.first.title).to eq(recipe.title)
      end

      it "set the @recipe veriable" do        
        expect(assigns[:recipe]).to eq(recipe)
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

    let(:recipe) {Fabricate(:recipe)}
    before {
      delete :destroy, id: recipe.slug
    }

    it "delete the recipe" do
      expect(Recipe.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_recipes_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

  describe 'DELETE destroy' do

    let(:recipe) {Fabricate(:recipe)}
    before {
      delete :destroy, id: recipe.slug
    }

    it "delete the recipe" do
      expect(Recipe.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_recipes_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::RecipesController do

  let(:recipe) {Fabricate(:recipe)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, recipe: Fabricate.attributes_for(:recipe)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: recipe.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: recipe.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: recipe.slug}
  end

end