require 'spec_helper'

describe Admin::MedicalActivitiesController do

  before do
    set_current_user(Fabricate(:admin))
  end

  describe 'GET index' do

    it "set @medical_activities" do  
      get :index
      expect(assigns(:medical_activities_1)).to eq([])
      expect(assigns(:medical_activities_2)).to eq([])
    end

    it "devide the medical activities well for odd numbers" do
      activity2 = Fabricate(:medical_activity, name: 'ממריץ')
      activity1 = Fabricate(:medical_activity, name: 'מחזק')
      activity3 = Fabricate(:medical_activity, name: 'משלשל')
      get :index
      expect(assigns(:medical_activities_1)).to eq([activity1, activity2])
      expect(assigns(:medical_activities_2)).to eq([activity3])
    end

    it "devide the medical activities well for even numbers" do      
      activity3 = Fabricate(:medical_activity, name: 'ממריץ')
      activity2 = Fabricate(:medical_activity, name: 'מחזק')
      activity4 = Fabricate(:medical_activity, name: 'משלשל')
      activity1 = Fabricate(:medical_activity, name: 'אנטי ויראלי')
      get :index
      expect(assigns(:medical_activities_1)).to eq([activity1, activity2])
      expect(assigns(:medical_activities_2)).to eq([activity3, activity4])
    end

  end

  describe 'POST create' do

    context "with valid input" do

      before do
        post :create, medical_activity: Fabricate.attributes_for(:medical_activity)
      end

      it "create a medical_activity" do
        expect(MedicalActivity.count).to eq(1)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_medical_activities_path
      end

    end

    context "with invalid input" do

      before do
        post :create, medical_activity: Fabricate.attributes_for(:medical_activity, name: nil)
      end

      it "dose not create medical_activity" do
        expect(MedicalActivity.count).to eq(0)
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

      it "render :new" do
        expect(response).to render_template :new
      end 

      it "set @medical_activity" do
        expect(assigns(:medical_activity)).to be_instance_of(MedicalActivity)
      end
    end
  end

  describe 'GET edit' do

    let(:medical_activity) {Fabricate(:medical_activity)}
    before {
      get :edit , id: medical_activity.slug
    }

    it "set the @medical_activity veriable" do        
      expect(assigns[:medical_activity]).to eq(medical_activity)
    end

  end

  describe 'PATCH update' do

    let(:medical_activity) { Fabricate(:medical_activity) }

    context "with valid input" do
      before {
        patch :update, id: medical_activity.slug ,medical_activity: {english_name: 'New name'}
      }

      it "update the medical_activity name" do
        expect(medical_activity.reload.english_name).to eq('New Name')
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "redirect to index admin" do
        expect(response).to redirect_to admin_medical_activities_path
      end

    end

    context "with invalid input" do

      before {
        patch :update, id: medical_activity.slug, medical_activity: {name: nil}
      }

      it "does not update the medical_activity" do
        expect(MedicalActivity.first.name).to eq(medical_activity.name)
      end

      it "set the @medical_activity veriable" do        
        expect(assigns[:medical_activity]).to eq(medical_activity)
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

    let(:medical_activity) {Fabricate(:medical_activity)}
    before {
      delete :destroy, id: medical_activity.slug
    }

    it "delete the medical_activity" do
      expect(MedicalActivity.count).to eq(0)
    end

    it "redirect to index admin" do
      expect(response).to redirect_to admin_medical_activities_path
    end

    it "set notice message" do
      expect(flash[:notice]).to be_present
    end

  end

end

describe Admin::MedicalActivitiesController do

  let(:medical_activity) {Fabricate(:medical_activity)}

  it_behaves_like "require_admin" do
    let(:action) {get :index}
  end

  it_behaves_like "require_admin" do
    let(:action) {post :create, medical_activity: Fabricate.attributes_for(:medical_activity)}
  end

  it_behaves_like "require_admin" do
    let(:action) {get :edit , id: medical_activity.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {patch :update, id: medical_activity.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: medical_activity.slug}
  end

  it_behaves_like "require_admin" do
    let(:action) {delete :destroy, id: medical_activity.slug}
  end

end