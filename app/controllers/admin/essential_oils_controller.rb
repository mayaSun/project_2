class Admin::EssentialOilsController <AdminController

  def index
    @essential_oils = EssentialOil.order(:name).all
  end

  def new
     @essential_oil = EssentialOil.new
  end

  def create
    @essential_oil = EssentialOil.new(essential_oil_params)
    if @essential_oil.save
      flash[:notice] = "#{@essential_oil.name} was added"
      redirect_to admin_essential_oils_path
    else
      flash[:error] = "The essential_oil #{@essential_oil.name} was NOT added"
      @essential_oils = EssentialOil.all
      render :new
    end  
  end

  def edit
    @essential_oil = EssentialOil.find_by(slug: params[:id])
  end

  def update
    @essential_oil = EssentialOil.find_by(slug: params[:id])
    if @essential_oil.update(essential_oil_params)
      flash[:notice] = "#{@essential_oil.name} was updated"
      redirect_to admin_essential_oils_path
    else
      flash[:error] = "#{@essential_oil.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    essential_oil = EssentialOil.find_by(slug: params[:id])
    essential_oil.delete
    flash[:notice] = "#{essential_oil.name} was deleted"
    redirect_to admin_essential_oils_path
  end

  private

  def essential_oil_params
    params.require(:essential_oil).permit(:name, :english_name, :price_5ml, :price_10ml, :price_50ml, :image, :use_instructions, :warnings)
  end

end