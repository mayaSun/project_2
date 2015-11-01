class AdminController <ApplicationController

  layout 'admin'
  before_action  :ensure_admin

  private

  def ensure_admin
    if !logged_in? || !current_user_admin?
      flash[:error] = "אזור חסום"
      redirect_to home_path
    end
  end

end