class MedicinalHerbsController <ApplicationController

  def index
    @medicinal_herbs = MedicinalHerb.order(:name).all
  end

  def show
    @medicinal_herb = MedicinalHerb.find_by(slug: params[:id])
    @products = @medicinal_herb.products
  end

end