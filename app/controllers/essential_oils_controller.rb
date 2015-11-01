class EssentialOilsController <ApplicationController

  def show
    @essential_oil = EssentialOil.find_by(slug: params[:id])
    @essential_oils = EssentialOil.order(:name).all - [@essential_oil]
  end

  def index
    @essential_oils = EssentialOil.all.order(:name)
  end

end