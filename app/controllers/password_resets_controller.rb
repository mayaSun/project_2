class PasswordResetsController <ApplicationController

  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user
      @user.generate_token
      ApplicationMailer.reset_user_password(@user.reload).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:error] = params[:email].blank? ? "האי מייל לא יכול להשאר רייק" : "האי מייל אינו מוכר במערכת"
      render :new
    end 
  end

  def confirm

  end

  def edit
    if params[:token] != nil
      @user = User.find_by(token: params[:token])
    end    
    if !@user
      redirect_to invalid_token_path
    end
  end

  def update
    @user = User.find_by(token: params[:user_token])
    if @user && params[:password].length >= 5  && @user.update(password: params[:password])
        @user.delete_reset_password_token
        flash[:notice] = "סיסמתך עודכנה"
        redirect_to home_path
    else
      flash[:error] = "על הסיסמה להיות באורך 5 תוים לפחות"
      render :edit
    end  

  end

end