class Admin::RecipesController <AdminController

  def index
    @recipes = Recipe.order(:created_at).all
  end

  def new
     @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "#{@recipe.title} was added"
      redirect_to admin_recipes_path
    else
      flash[:error] = "The recipe #{@recipe.title} was NOT added"
      @recipes = Recipe.all
      render :new
    end  
  end

  def edit
    @recipe = Recipe.find_by(slug: params[:id])
  end

  def update
    @recipe = Recipe.find_by(slug: params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "#{@recipe.title} was updated"
      redirect_to admin_recipes_path
    else
      flash[:error] = "#{@recipe.title} was NOT updated"
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find_by(slug: params[:id])
    recipe.delete
    flash[:notice] = "#{recipe.title} was deleted"
    redirect_to admin_recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :text, :image)
  end

end