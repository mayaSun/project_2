class OrdersController <ApplicationController

  def show
    @order = Order.find_by(slug: params[:id])
    if ! (logged_in? && ( (@order.user && @order.user == current_user) || current_user_admin?))
      flash[:error] = "אנה התחבר"
      redirect_to :back
    end 
  end

  def new
    if shopping_cart.empty?
      flash[:notice] = "עגלת הקניות ריקה.."
      redirect_to :back
    else
      @shipping_address = Address.new
    end
  end

  def create  
    @shipping_address = Address.new(address_params.merge( "country_code" => 'IL', "shipping" => true))
    if params[:accept_terms_and_conditions]
      if check_shopping_cart_stock == true
        if @shipping_address.save
          if params[:billing]
            @shipping_address.update_attributes(billing: true)
          end
          @order = Order.create(shipping_address_id: @shipping_address.id, user: logged_in? ? current_user : nil, billing_address_id: params[:billing] ? @shipping_address.id : nil, delivery_method: params[:delivery_method])
          session[:order_id] = @order.id
          redirect_to @order.paypal_url(shopping_cart, params[:billing] ? @shipping_address : nil)
        else
          render :new
        end 
      else
        flash[:error] = "אחד המוצרים לא נמצא במלאי, הזמנתך עודכנה"
        render :new
      end
    else
      flash[:error] = "אנה אשר כי קראת והסכמתה עם  תנאי השימוש באתר."
      render :new
    end  
  end
  
  protect_from_forgery except: [:paypal_hook]

  def paypal_hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    order = Order.find_by(id: params[:invoice].to_i)
    if !(order.status == 'Paid' && order.reference_id == params[:txn_id])
      if order.status == nil
        handle_order_items_and_address(params)
      end
      if params[:receiver_email] == "holylandherbs@gmail.com" 
        order.update_attributes(reference_id: params[:txn_id])   
        if status == "Completed"
          handle_order(order.reload, 'paypal')
        elsif status == "Pending"
          order.update_attributes(status: "Pending")
          ApplicationMailer.order_pending(order.reload).deliver
        else
          order.update_attributes(status: params[:payment_status])
        end
      else
        order.update_attributes(status: "Fraud Receiver")
      end 
    end         
    render nothing: true
  end


  def terms_and_conditions
    respond_to do |format|
      format.html
      format.js
    end 
  end

  private

  def address_params
    params.require(:address).permit(:first_name,:last_name,:address_line1,:address_line2,:city,:state_code,:postal_code,:phone_number,:email)
  end

  def handle_order_items_and_address(params = {})
    order = Order.find_by(id: params[:invoice].to_i)
    (1..params[:num_cart_items].to_i).each do |i|
      ShoppingCartItem.create(
        sellable_type: params["option_name1_#{i}"] ,
        sellable_id: params["item_number#{i}"].to_i, 
        qty: params["quantity#{i}"].to_i, 
        package_type: params["option_name2_#{i}"], 
        position: order)
    end
    if !order.billing_address_id
      address = Address.create(
        billing: true, 
        first_name: params[:first_name], 
        last_name: params[:last_name], 
        address_line1: params[:address_street], 
        city: params[:address_city],
        country_code: params[:address_country_code],
        state_code: params[:address_state],
        postal_code: params[:address_zip],
        email: params[:payer_email],
        status: params[:memo])
      order.update_attributes(billing_address_id: address.id)
    end
  end

  def handle_order(order, payment_method) 
    order.status = 'Paid'
    order.save
    #order.update_stock
    ApplicationMailer.order_approval(order).deliver
  end

end