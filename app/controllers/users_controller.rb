class UsersController <ApplicationController

  respond_to :html, :js

  def new   
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      set_shopping_items(@user)
      flash[:notise] = "ברוך הבא למאגר המשתמשים באתר עשבי ארץ ישראל"
      redirect_to home_path      
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(slug: params[:id])
    ensure_current_user_or_admin(@user)
  end

  def update
    @user = User.find_by(slug: params[:id])
    if ensure_current_user_or_admin(@user)
      if @user.authenticate(params[:authentication])
        if @user.update(user_params)
          current_user.reload
          flash[:notice] = "פרטי החשבון עודכנו"
        else
          flash[:error] = "פרטי החשבון לא עודכנו"
        end
      else
        flash[:error] = "אימות הסיסמא נכשל"
      end
      render :my_account
    end
  end

  def edit_password
    @user = User.find_by(slug: params[:id])
    ensure_current_user_or_admin(@user)
  end

  def my_account
    if !logged_in?
      redirect_to home_path
    end
  end

  def my_orders
    if logged_in?
      @orders = current_user.orders.order('updated_at')
    else
      flash[:error] = "פעולה המצריכה התחברות"
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def ensure_current_user_or_admin(user)
    if !logged_in? || (!current_user_admin? && user != current_user)
      flash[:error] = "פעולה המצריכה התחברות"
      redirect_to home_path
      return false
    else
      return true
    end
  end

end