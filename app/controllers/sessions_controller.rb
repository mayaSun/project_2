class SessionsController <ApplicationController

  skip_before_action :in_build_state, only: [:new, :create]

  def new
    respond_to do |format|
      format.html {render 'new', :layout => false  } 
      format.js
    end 
  end

  def create
    reset_session
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        format.js {render 'shared/close_madal.js.haml'}
        format.html {redirect_to home_path}
      end 
    else
      flash.now[:error] = "האי מייל אינו תואם את הסיסמה"
      respond_to do |format|
        format.js 
      end
    end 
  end

  def destroy
    reset_session
    session[:user_id] = nil
    @current_user = nil
    redirect_to home_path
  end

  
end