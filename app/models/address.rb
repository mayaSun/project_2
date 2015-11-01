class Address <ActiveRecord::Base
  include Sluggable
  sluggable_column :slug_column

  validates_presence_of :first_name , :last_name, :address_line1, :city, :country_code, :email  
  belongs_to :user

  def slug_column
    Array.new(8){[*"A".."Z", *"0".."9"].sample}.join
  end

  def delete_type(type)
    if (type == 'shipping' && billing == false) || (type == 'billing' && shipping == false)
      update_column(:user_id, nil)
    elsif type == 'shipping'
      update_column(:shipping, false)
    elsif type == 'billing'
      update_column(:billing, false)
    end
  end

end