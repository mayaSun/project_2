class AddressesController <ApplicationController

  before_action  :ensure_login, only: [:index, :new, :create, :edit, :update, :destroy]

  before_filter do
    locale = params[:locale]
    Carmen.i18n_backend.locale = locale if locale
  end

  def subregion_options
    render partial: 'subregion_select'
  end

  def index
    @shipping_addresses = current_user.shipping_addresses
    @billing_addresses = current_user.billing_addresses
  end

  def new
    @address = Address.new
    respond_to do |format|
      format.html 
      format.json { render json: @address }
    end
  end

  def create
    @address = Address.new(address_params)
    @address.update(country_code: 'IL',shipping: params[:shipping], billing: params[:billing], user: logged_in? ? current_user : nil)
    if @address.save
      flash[:notice] = "הכתובת נשמרה"
      redirect_to addresses_path
    else
      render :new
    end
  end

  def edit
    @address = Address.find_by(slug: params[:id])
  end

  def update
    @address = Address.find_by(slug: params[:id])
    if @address.user == current_user
      if @address.update(address_params)
        flash[:notice] = "הכתובת עודכנה" 
        redirect_to addresses_path
      else
        render :edit
      end  
    else
      flash[:error] = "אינך רשאי לעדכן כתובת זו"
      redirect_to home_path
    end
  end

  def destroy
    address = Address.find_by(slug: params[:id])
    if address.user == current_user
      address.delete_type(params[:type])
      redirect_to addresses_path
    else
      flash[:error] = "אינך רשאי למחוק כתובת זו"
      redirect_to home_path
    end
  end

  private

  def ensure_login
    if !logged_in?
      redirect_to home_path
    end
  end

  def address_params
    params.require(:address).permit(:first_name,:last_name,:address_line1,:address_line2,:city,:state_code,:postal_code,:phone_number,:email)
  end

end