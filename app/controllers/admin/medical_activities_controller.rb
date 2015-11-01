class Admin::MedicalActivitiesController <AdminController

  def index
    @medical_activities_1 = MedicalActivity.order(:name).in_groups(2,false)[0]
    @medical_activities_2 = MedicalActivity.order(:name).in_groups(2,false)[1]
  end

  def new
     @medical_activity = MedicalActivity.new
  end

  def create
    @medical_activity = MedicalActivity.new(medical_activity_params)
    if @medical_activity.save
      flash[:notice] = "#{@medical_activity.name} was added"
      redirect_to admin_medical_activities_path
    else
      flash[:error] = "The medical activity #{@medical_activity.name} was NOT added"
      render :new
    end  
  end

  def edit
    @medical_activity = MedicalActivity.find_by(slug: params[:id])
  end

  def update
    @medical_activity = MedicalActivity.find_by(slug: params[:id])
    if @medical_activity.update(medical_activity_params)
      flash[:notice] = "#{@medical_activity.name} was updated"
      redirect_to admin_medical_activities_path
    else
      flash[:error] = "#{@medical_activity.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    medical_activity = MedicalActivity.find_by(slug: params[:id])
    medical_activity.delete
    flash[:notice] = "#{medical_activity.name} was deleted"
    redirect_to admin_medical_activities_path
  end

  private

  def medical_activity_params
    params.require(:medical_activity).permit(:name, :english_name, :description, :medicinal_herb_ids => [])
  end

end