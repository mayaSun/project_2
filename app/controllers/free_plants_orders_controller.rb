class FreePlantsOrdersController < ApplicationController

  def new
    @address = Address.new
    respond_to do |format|
      format.html
      format.js
    end 
  end

  def create
    @address = Address.new(address_params.merge( "country_code" => 'IL', "shipping" => true))
    if @address.save
      @free_plants_order = FreePlantsOrder.new(address: @address, delivery_method: params[:delivery_method], plant_1: params[:plants] ? params[:plants][0] : nil, plant_2: params[:plants] ? params[:plants][1] : nil) 
      if @free_plants_order.save
        respond_to do |format|
          format.js {render 'shared/close_madal.js.haml'}
          format.html {redirect_to home_path}
        end 
      else
        @address.delete
        flash[:error] = "הזמנתך לא נשמרה, יתכן שהאי מייל שהזנת כבר קיים ברשימה"
        respond_to do |format|
          format.js 
        end 
      end
    else
      flash[:error] = "הזמנתך נשמרה"
      respond_to do |format|
        format.js 
      end     
    end
  end


  private

  def address_params
    params.require(:address).permit(:first_name,:last_name,:address_line1,:address_line2,:city,:state_code,:postal_code,:phone_number,:email)
  end

end