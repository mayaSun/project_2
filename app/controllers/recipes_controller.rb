class RecipesController <ApplicationController

  def index
    @recipes = Recipe.order(:created_at).all
  end

end
