class Admin::ProductsController <AdminController

  def index
    @categories = Category.all
  end

  def new
     @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "#{@product.name} was added"
      redirect_to admin_products_path
    else
      flash[:error] = "The product #{@product.name} was NOT added"
      @products = Product.all
      render :new
    end  
  end

  def edit
    @product = Product.find_by(slug: params[:id])
  end

  def update
    @product = Product.find_by(slug: params[:id])
    if @product.update(product_params)
      flash[:notice] = "#{@product.name} was updated"
      redirect_to admin_products_path
    else
      flash[:error] = "#{@product.name} was NOT updated"
      render :edit
    end
  end

  def destroy
    product = Product.find_by(slug: params[:id])
    product.delete
    flash[:notice] = "#{product.name} was deleted"
    redirect_to admin_products_path
  end

  def stock
    @products = Product.all.order('stock')
  end

  def update_stock
    @product = Product.find_by(slug: params[:id])
    if @product.update(stock: params[:stock])
      flash[:notice] = "#{@product.name} stock was updated"
    else
      flash[:error] = "Error: #{@product.name} stock was NOT updated"
    end
    @products = Product.all.order('stock')
    render :stock
  end

  private

  def product_params
    params.require(:product).permit(:name, :english_name, :price, :category_id, :image,  :stock, :short_description, :long_description, :use_instructions, :ingridience, :warnings, :quantity, :quantity_unit, :package_weight, :energy, :carbohydrates, :protein, :fat, :saturated_fat, :cholesterol, :sodium ,:other_nutrients,:medium_package_quantity, :medium_package_price, :big_package_quantity, :big_package_price, :medicinal_herb_ids => [])
  end

end