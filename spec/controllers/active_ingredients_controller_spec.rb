require 'spec_helper'

describe ActiveIngredientsController do
  describe 'GET show' do

    let(:active_ingredient) { Fabricate(:active_ingredient) }
    before {
      get :show, id: active_ingredient.slug
    }

    it "set @active_ingredient" do      
      expect(assigns(:active_ingredient)).to be_instance_of(ActiveIngredient)
    end

    it "set @medicinal_herbs" do      
      expect(assigns(:medicinal_herbs)).to eq([])
    end

  end

  describe 'GET index' do

    it "set @active_ingredients" do  
      get :index
      expect(assigns(:active_ingredients_1)).to eq([])
      expect(assigns(:active_ingredients_2)).to eq([])
      expect(assigns(:active_ingredients_3)).to eq([])
    end

    it "devide the active ingredient well for 3% => 0 numbers" do
      activity2 = Fabricate(:active_ingredient, name: 'ממריץ')
      activity1 = Fabricate(:active_ingredient, name: 'מחזק')
      activity3 = Fabricate(:active_ingredient, name: 'משלשל')
      get :index
      expect(assigns(:active_ingredients_1)).to eq([activity1])
      expect(assigns(:active_ingredients_2)).to eq([activity2])
      expect(assigns(:active_ingredients_3)).to eq([activity3])
    end

    it "devide the active ingredient well for 3% => 1 numbers" do      
      activity3 = Fabricate(:active_ingredient, name: 'ממריץ')
      activity2 = Fabricate(:active_ingredient, name: 'מחזק')
      activity4 = Fabricate(:active_ingredient, name: 'משלשל')
      activity1 = Fabricate(:active_ingredient, name: 'אנטי ויראלי')
      get :index
      expect(assigns(:active_ingredients_1)).to eq([activity1, activity2])
      expect(assigns(:active_ingredients_2)).to eq([activity3])
      expect(assigns(:active_ingredients_3)).to eq([activity4])
    end

    it "devide the active ingredient well for 3% => 2 numbers" do      
      activity3 = Fabricate(:active_ingredient, name: 'ממריץ')
      activity2 = Fabricate(:active_ingredient, name: 'מחזק')
      activity4 = Fabricate(:active_ingredient, name: 'משלשל')
      activity1 = Fabricate(:active_ingredient, name: 'אנטי ויראלי')
      activity5 = Fabricate(:active_ingredient, name: 'תוען באנרגיה')
      get :index
      expect(assigns(:active_ingredients_1)).to eq([activity1, activity2])
      expect(assigns(:active_ingredients_2)).to eq([activity3, activity4])
      expect(assigns(:active_ingredients_3)).to eq([activity5])
    end

  end


end