class Admin::MedicinalHerbsController <AdminController

  def index
    @medicinal_herbs = MedicinalHerb.order(:name).all
  end

  def new
     @medicinal_herb = MedicinalHerb.new
  end

  def create
    @medicinal_herb = MedicinalHerb.new(medicinal_herb_params)
    if  (return_val = @medicinal_herb.validate_research_links_data(params[:medicinal_herb][:research_links])) != true
      flash[:error] = return_val
      render :new
    elsif @medicinal_herb.save
      @medicinal_herb.set_research_links_data(params[:medicinal_herb][:research_links])
      flash[:notice] = "#{@medicinal_herb.name} was added"
      redirect_to admin_medicinal_herbs_path
    else
      flash[:error] = "The medicinal_herb #{@medicinal_herb.name} was NOT added"
      render :new
    end  
  end

  def edit
    @medicinal_herb = MedicinalHerb.find_by(slug: params[:id])
  end

  def update
    @medicinal_herb = MedicinalHerb.find_by(slug: params[:id])
    if params[:medicinal_herb][:research_links] && (return_val = @medicinal_herb.validate_research_links_data(params[:medicinal_herb][:research_links])) != true
      flash[:error] = return_val
      render :edit
    elsif @medicinal_herb.update(medicinal_herb_params)
      @medicinal_herb.set_research_links_data(params[:medicinal_herb][:research_links])
      flash[:notice] = "#{@medicinal_herb.name} was updated"
      redirect_to admin_medicinal_herbs_path
    else
      flash[:error] = "#{@medicinal_herb.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    medicinal_herb = MedicinalHerb.find_by(slug: params[:id])
    medicinal_herb.delete
    flash[:notice] = "#{medicinal_herb.name} was deleted"
    redirect_to admin_medicinal_herbs_path
  end

  private

  def medicinal_herb_params
    params.require(:medicinal_herb).permit(:name, :english_name, :latin_name, :description, :medicinal_properties, :use_instructions, :warnings, :image, :sprout_image, :other_qualities, :research_link_ids => [])
  end

end