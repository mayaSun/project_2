class ActiveIngredientsController <ApplicationController

  def index
    @active_ingredients_1 = ActiveIngredient.order(:name).in_groups(3,false)[0]
    @active_ingredients_2 = ActiveIngredient.order(:name).in_groups(3,false)[1]
    @active_ingredients_3 = ActiveIngredient.order(:name).in_groups(3,false)[2]
  end

  def show
    @active_ingredient = ActiveIngredient.find_by(slug: params[:id])
    @medicinal_herbs = @active_ingredient.medicinal_herbs
  end

end