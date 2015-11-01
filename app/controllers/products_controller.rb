class ProductsController <ApplicationController

  def show
    @product = Product.find_by(slug: params[:id])
    @related_products = @product.category.products - [@product]
  end

  def index
    @products = Product.order(:name).all
  end

end