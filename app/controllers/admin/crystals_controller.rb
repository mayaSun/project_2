class Admin::CrystalsController <AdminController

  def index
    @crystals = Crystal.order(:name).all
  end

  def new
     @crystal = Crystal.new
  end

  def create
    @crystal = Crystal.new(crystal_params)
    if @crystal.save
      flash[:notice] = "#{@crystal.name} was added"
      redirect_to admin_crystals_path
    else
      flash[:error] = "The crystal #{@crystal.name} was NOT added"
      @crystals = Crystal.all
      render :new
    end  
  end

  def edit
    @crystal = Crystal.find_by(slug: params[:id])
  end

  def update
    @crystal = Crystal.find_by(slug: params[:id])
    if @crystal.update(crystal_params)
      flash[:notice] = "#{@crystal.name} was updated"
      redirect_to admin_crystals_path
    else
      flash[:error] = "#{@crystal.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    crystal = Crystal.find_by(slug: params[:id])
    crystal.delete
    flash[:notice] = "#{crystal.name} was deleted"
    redirect_to admin_crystals_path
  end

  private

  def crystal_params
    params.require(:crystal).permit(:name, :english_name, :price, :hardness, :image, :image_link,  :chemical_formula, :qualities, :use_instructions, :warnings)
  end

end