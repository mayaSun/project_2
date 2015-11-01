class ApplicationMailer < ActionMailer::Base

  default from: "holylandherbs@gmail.com"

  def contact_us_mail(params={})
    @message = params[:message]
    @name = params[:name]
    @subject = params[:subject]
    mail from: params[:email] , to: 'holylandherbs@gmail.com', subject: 'Contact Us Email from:' + params[:name]
  end

  def order_approval(order)
    @order = order
    mail to: order.billing_address.email, subject: 'אישור תשלום על ההזמנה'
  end

  def order_pending(order)
    @order = order
    mail to: order.billing_address.email, subject: 'תרם התקבל אישור תשלום על ההזמנה'
  end

  def order_delivary_approval(order)
    @order = order
    mail to: order.shipping_address.email, subject: 'Your order approval and details'
  end

  def reset_user_password(user)
    @user = user
    mail to: @user.email, subject: "חידוש סיסמה לאתר של עשבי ארץ הקודש"
  end

end