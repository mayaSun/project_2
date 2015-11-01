class ContactUsController <ApplicationController

  def create
    if !params[:name] || !params[:email] || !params[:subject] || !params[:message] || params[:name].empty? || params[:email].empty? || params[:subject].empty? || params[:message].empty?
      flash[:error] = "אנה מלא את כל השדות"
      render :new
    else
      ApplicationMailer.contact_us_mail(params).deliver
      flash[:notice] = "הודעתך נמסרה"
      redirect_to home_path
    end
  end

end