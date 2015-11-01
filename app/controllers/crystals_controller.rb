class CrystalsController < ApplicationController

  def index
    @crystals = Crystal.order(:name).all
  end

  def show
    @crystal = Crystal.find_by(slug: params[:id])
  end

end