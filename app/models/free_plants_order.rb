class FreePlantsOrder <ActiveRecord::Base

  validates_presence_of :address , :delivery_method
  belongs_to :address

  validate :validates_uniquness_of_email

  def validates_uniquness_of_email
    if address && FreePlantsOrder.all.map{|x| x.address.email}.include?(address.email)
      errors.add(:address ,"האי מייל שלך כבר קיים במערכת")
    end
  end

end