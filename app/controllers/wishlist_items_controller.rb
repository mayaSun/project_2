class UserWishlistItemsController <ApplicationController

  def index
    if logged_in?
      @wishlist = current_user.wishlist_items
    else
      @wishlist = session[:wishlist_item].map.with_index{|x,i| GuestWishlist.new(product_id: session[:wishlist_item][i])}
    end  
  end

  def create
    if logged_in?
      wishlist_item = current_user.wishlist_items.new(product_id: params[:product_id])
      if wishlist_item.save
        flash[:notice] = "#{wishlist_item.name} is all ready in your Wishlist"
      else
        flash[:error] = "The product was not added to your wishlist"
      end
    else
      if session[:wishlist_item].index(params[:product_id].to_s)
        flash[:error] = "Product is all ready in your wishlist"
      else
        session[:wishlist_item][session[:wishlist_item].size] = params[:product_id]
        flash[:notice] = "The product was added to your Wishlist"
      end
    end
    redirect_to :back  
  end

  def destroy
    if logged_in?
      wishlist_item = UserWishlistItem.find(params[:id])
      if params[:add_to_cart]
        shopping_cart_item = UserShoppingCartItem.new(position: current_user, product_id: wishlist_item.product_id, qty: 1)
        if shopping_cart_item.save
          flash[:notice] = "#{wishlist_item.name} was added to your Shopping Cart!"
        end
      else
        flash[:notice] = "#{wishlist_item.name} was removed from your Wishlist"
      end
      wishlist_item.destroy
    else
      if params[:add_to_cart]
        session[:shopping_cart_item][session[:shopping_cart_item].size] = params[:id]
        session[:shopping_cart_item_qty][session[:shopping_cart_item_qty].size] = 1
        flash[:notice] = "The product was added to your Shopping Cart!"
      else
        flash[:notice] = "The product was removed from your Wishlist"
      end
      session[:wishlist_item].delete(params[:id])
    end
    redirect_to :back
  end

end