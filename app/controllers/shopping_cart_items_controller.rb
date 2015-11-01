class ShoppingCartItemsController <ApplicationController

  def index
  end

  def create 
    package_type = params["package_type" + params[:sellable_id].to_s]
    if logged_in?
      @shopping_cart_item = ShoppingCartItem.new(position: current_user,sellable_id: params[:sellable_id], sellable_type: params[:sellable_type], package_type: package_type, qty: params[:qty])
      if @shopping_cart_item.save
        flash[:notice] = "המוצר נוסף לסל הקניות"
      else
        flash[:error] = "על הכמות להיות מספר חיובי שלם"
      end
    else
      if GuestShoppingCart.params_validated?(params.merge(package_type: package_type))
        if params[:sellable_type] != 'EssentialOil' && shopping_cart_item_index(params[:sellable_type], params[:sellable_id]) != nil
          flash[:error] = "המוצר כבר נמצא בסל הקניות"
        else
          size = session[:shopping_cart_item].size
          session[:shopping_cart_item][size] = params[:sellable_id]
          session[:shopping_cart_item_type][size] = params[:sellable_type]
          session[:shopping_cart_item_qty][size] = params[:qty]
          session[:shopping_cart_item_package_type][size] = package_type
          flash[:notice] = "המוצר נוסף לסל הקניות"
        end
      else
        flash[:error] = "על הכמות להיות מספר חיובי שלם"
      end      
    end
    redirect_to :back  
  end

  def update
    if logged_in?
      @shopping_cart_item = ShoppingCartItem.find(params[:id])
      if @shopping_cart_item.update_attributes(qty: params[:qty])
       flash[:notice] = "הכמות עודכנה"
      else
        flash[:error] = "על הכמות להיות מספר חיובי שלם"
      end 
    else
      if GuestShoppingCart.qty_validated?(params[:qty])
        i = shopping_cart_item_index(params[:sellable_type], params[:id])
        session[:shopping_cart_item_qty][i] = params[:qty]
        flash[:notice] = "הכמות עודכנה"
      else
        flash[:error] = "על הכמות להיות מספר חיובי שלם"
      end
    end
    redirect_to :back
  end 

  def destroy
    if logged_in?
      @shopping_cart_item = ShoppingCartItem.find(params[:id])
      @shopping_cart_item.destroy
    else
      i =  shopping_cart_item_index(params[:sellable_type], params[:id])
      session[:shopping_cart_item].delete_at(i)
      session[:shopping_cart_item_qty].delete_at(i)
      session[:shopping_cart_item_type].delete_at(i)
      session[:shopping_cart_item_package_type].delete_at(i)
    end
    flash[:notice] = "המוצר נמחק מסל הקניות"
    redirect_to :back
  end

end
