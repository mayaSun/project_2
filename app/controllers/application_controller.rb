class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method  :logged_in?, :current_user, :current_user_admin?, :shopping_cart, :total_bill, :wishlist_count, :shop_owner? 
  before_filter :set_session_verables
  #before_action :in_build_state

  def set_session_verables
    if !session[:shopping_cart_item]
      session[:shopping_cart_item] = []
      session[:shopping_cart_item_type] = []
      session[:shopping_cart_item_qty] = []
      session[:shopping_cart_item_package_type] = []
      session[:wishlist_item] = []
    elsif session[:order_id] && ( Order.find_by(id: session[:order_id]).status == "Paid" || Order.find_by(id: session[:order_id]).status == "Pending")
      session[:order_id] = nil
      if logged_in?
        current_user.shopping_cart_items.each do |item|
          item.destroy
        end
      else  
        session[:shopping_cart_item] = []
        session[:shopping_cart_item_type] = []
        session[:shopping_cart_item_qty] = []
        session[:shopping_cart_item_package_type] = []
      end
    end
  end

  def record_not_found
    render '404', status: 404
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end  

  def logged_in?
    !!current_user
  end

  def current_user_admin?
    current_user.role == "admin" || current_user.role == "shop_owner" 
  end

  def in_build_state
    if Rails.env.production?
      if   !current_user || !current_user_admin?
        render '/pages/on_development', :layout => false 
      end
    end  
  end

  def shop_owner?(user)
    user.role == "shop_owner" 
  end

  def shopping_cart
    if logged_in?
      current_user.shopping_cart_items
    else
      session[:shopping_cart_item].map.with_index{|x,i| GuestShoppingCart.new(sellable_id: session[:shopping_cart_item][i], sellable_type: session[:shopping_cart_item_type][i], package_type: session[:shopping_cart_item_package_type][i], qty: session[:shopping_cart_item_qty][i])}
    end
  end

  def total_bill
    if logged_in?
      current_user.total_bill
    else
      shopping_cart.map(&:total_price).inject(0, :+)
    end
  end

  def set_shopping_items(user)
    session[:shopping_cart_item].each_index do |i|
      ShoppingCartItem.create(position: user,sellable_id: session[:shopping_cart_item][i].to_i, sellable_type: session[:shopping_cart_item_type][i], package_type: session[:shopping_cart_item_package_type][i]  ,qty: session[:shopping_cart_item_qty][i].to_i)    
    end
    #session[:wishlist_item].each_index do |i|
    #  user.wishlist_items.create(product_id: session[:wishlist_item][i].to_i)    
    #end
    session[:shopping_cart_item].clear
    session[:shopping_cart_item_qty].clear
    session[:shopping_cart_item_type].clear
    session[:shopping_cart_item_package_type].clear
    session[:wishlist_item].clear
  end

  def shopping_cart_item_index(type, id)
    session[:shopping_cart_item].each_with_index do |item_id , index|
      if item_id == id && session[:shopping_cart_item_type][index] == type
        return index
      end
    end
    return nil
  end

  def wishlist_count
    if logged_in?
      current_user.wishlist_items.count
    else
      session[:wishlist_item].count
    end
  end

  def check_shopping_cart_stock  
    all_in_stock = true
    shopping_cart.each do |shopping_cart_item|
      if shopping_cart_item.sellable_type == 'Product' 
        in_stock = shopping_cart_item.sellable.stock
        if in_stock <  shopping_cart_item.qty
          if logged_in?
            shopping_cart_item.update(qty: in_stock)
          else
            i = shopping_cart_item_index(shopping_cart_item.sellable_type, shopping_cart_item.sellable_id.to_s)
            session[:shopping_cart_item_qty][i] = in_stock.to_s
          end
          flash[:error] = "כרגע צודר #{shopping_cart_item.name} ניתן להזמנה רק #{in_stock} פעמים, הזמנתך עודכנה בהתאם.."
          all_in_stock = false
        end 
      end      
    end
    return all_in_stock 
  end
end
