class RecipesController <ApplicationController

  def index
    @recipes = Recipe.order(:title).all
  end

end
