class JewelriesController<ApplicationController

  def show
    @jewelry = Jewelry.find_by(slug: params[:id])
    @crystal_id = @jewelry.crystal_id
    jewelry_crystal = @jewelry.jewelry_crystal(@crystal_id)
    @price = @crystal_id ? jewelry_crystal.price : @jewelry.price
    @sellable_type = @crystal_id ? 'JewelryCrystal' : 'Jewelry' 
    @sellable_id = @crystal_id ? jewelry_crystal.id : @jewelry.id
  end

  def index
    @jewelries = Jewelry.all
  end

end