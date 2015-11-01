class MedicalActivitiesController <ApplicationController

  def index
    @medical_activities_1 = MedicalActivity.order(:name).in_groups(3,false)[0]
    @medical_activities_2 = MedicalActivity.order(:name).in_groups(3,false)[1]
    @medical_activities_3 = MedicalActivity.order(:name).in_groups(3,false)[2]
  end

  def show
    @medical_activity = MedicalActivity.find_by(slug: params[:id])
    @medicinal_herbs = @medical_activity.medicinal_herbs
  end

end