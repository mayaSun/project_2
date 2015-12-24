class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(slug: params[:id])
    @products = @category.products.order(:name)
  end

end