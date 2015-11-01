class JewelryCrystalsController<ApplicationController

  def show
    jewelry_crystal = JewelryCrystal.find_by(slug: params[:id])
    @jewelry = jewelry_crystal.jewelry
    @crystal_id = jewelry_crystal.crystal_id
    @price = jewelry_crystal.price
    @sellable_type = 'JewelryCrystal' 
    @sellable_id = jewelry_crystal.id
    render 'jewelries/show'
  end

end

