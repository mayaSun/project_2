class Admin::JewelriesController <AdminController

  def index
    @jewelries = Jewelry.order(:name).all
  end

  def new
     @jewelry = Jewelry.new
  end

  def create
    @jewelry = Jewelry.new(jewelry_params)
    if (return_val = @jewelry.validate_jewelry_crystals_data(params[:jewelry][:jewelry_crystals])) != true
      flash[:error] = return_val
      render :new
    elsif @jewelry.save
      @jewelry.set_jewelry_crystals_data(params[:jewelry][:jewelry_crystals])
      flash[:notice] = "#{@jewelry.name} was added"
      redirect_to admin_jewelries_path
    else
      flash[:error] = "The jewelry #{@jewelry.name} was NOT added"
      @jewelries = Jewelry.all
      render :new
    end  
  end

  def edit
    @jewelry = Jewelry.find_by(slug: params[:id])
  end

  def update
    @jewelry = Jewelry.find_by(slug: params[:id])
    if (return_val = @jewelry.validate_jewelry_crystals_data(params[:jewelry][:jewelry_crystals])) != true
      flash[:error] = return_val
      render :edit
    elsif @jewelry.update(jewelry_params)
      @jewelry.set_jewelry_crystals_data(params[:jewelry][:jewelry_crystals])
      flash[:notice] = "#{@jewelry.name} was updated"
      redirect_to admin_jewelries_path
    else
      flash[:error] = "#{@jewelry.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    jewelry = Jewelry.find_by(slug: params[:id])
    jewelry.delete
    flash[:notice] = "#{jewelry.name} was deleted"
    redirect_to admin_jewelries_path
  end

  private

  def jewelry_params
    params.require(:jewelry).permit(:name, :english_name, :price, :crystal_id, :image, :long_description,  :crystal_ids => [])
  end

end