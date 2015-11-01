class Admin::ActiveIngredientsController <AdminController

  def index
    @active_ingredients_1 = ActiveIngredient.order(:name).in_groups(2,false)[0]
    @active_ingredients_2 = ActiveIngredient.order(:name).in_groups(2,false)[1]
  end

  def new
     @active_ingredient = ActiveIngredient.new
  end

  def create
    @active_ingredient = ActiveIngredient.new(active_ingredient_params)
    if @active_ingredient.save
      flash[:notice] = "#{@active_ingredient.name} was added"
      redirect_to admin_active_ingredients_path
    else
      flash[:error] = "The medical activity #{@active_ingredient.name} was NOT added"
      render :new
    end  
  end

  def edit
    @active_ingredient = ActiveIngredient.find_by(slug: params[:id])
  end

  def update
    @active_ingredient = ActiveIngredient.find_by(slug: params[:id])
    if @active_ingredient.update_attributes(active_ingredient_params)
      flash[:notice] = "#{@active_ingredient.name} was updated"
      redirect_to admin_active_ingredients_path
    else
      flash[:error] = "#{@active_ingredient.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    active_ingredient = ActiveIngredient.find_by(slug: params[:id])
    active_ingredient.delete
    flash[:notice] = "#{active_ingredient.name} was deleted"
    redirect_to admin_active_ingredients_path
  end

  private

  def active_ingredient_params
    params.require(:active_ingredient).permit(:name, :english_name, :description, :medicinal_herb_ids => [])
  end

end