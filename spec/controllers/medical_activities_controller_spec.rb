require 'spec_helper'

describe MedicalActivitiesController do
  describe 'GET show' do

    let(:medical_activity) { Fabricate(:medical_activity) }
    before {
      get :show, id: medical_activity.slug
    }

    it "set @medical_activity" do      
      expect(assigns(:medical_activity)).to be_instance_of(MedicalActivity)
    end

    it "set @medicinal_herbs" do      
      expect(assigns(:medicinal_herbs)).to eq([])
    end

  end

  describe 'GET index' do

    it "set @medical_activities" do  
      get :index
      expect(assigns(:medical_activities_1)).to eq([])
      expect(assigns(:medical_activities_2)).to eq([])
      expect(assigns(:medical_activities_3)).to eq([])
    end

    it "devide the medical activities well for 3% => 0 numbers" do
      activity2 = Fabricate(:medical_activity, name: 'ממריץ')
      activity1 = Fabricate(:medical_activity, name: 'מחזק')
      activity3 = Fabricate(:medical_activity, name: 'משלשל')
      get :index
      expect(assigns(:medical_activities_1)).to eq([activity1])
      expect(assigns(:medical_activities_2)).to eq([activity2])
      expect(assigns(:medical_activities_3)).to eq([activity3])
    end

    it "devide the medical activities well for 3% => 1 numbers" do      
      activity3 = Fabricate(:medical_activity, name: 'ממריץ')
      activity2 = Fabricate(:medical_activity, name: 'מחזק')
      activity4 = Fabricate(:medical_activity, name: 'משלשל')
      activity1 = Fabricate(:medical_activity, name: 'אנטי ויראלי')
      get :index
      expect(assigns(:medical_activities_1)).to eq([activity1, activity2])
      expect(assigns(:medical_activities_2)).to eq([activity3])
      expect(assigns(:medical_activities_3)).to eq([activity4])
    end

    it "devide the medical activities well for 3% => 2 numbers" do      
      activity3 = Fabricate(:medical_activity, name: 'ממריץ')
      activity2 = Fabricate(:medical_activity, name: 'מחזק')
      activity4 = Fabricate(:medical_activity, name: 'משלשל')
      activity1 = Fabricate(:medical_activity, name: 'אנטי ויראלי')
      activity5 = Fabricate(:medical_activity, name: 'תוען באנרגיה')
      get :index
      expect(assigns(:medical_activities_1)).to eq([activity1, activity2])
      expect(assigns(:medical_activities_2)).to eq([activity3, activity4])
      expect(assigns(:medical_activities_3)).to eq([activity5])
    end

  end


end