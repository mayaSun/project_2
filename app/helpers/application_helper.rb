module ApplicationHelper

  def nav_active(path)
    if current_page?(path)    
      'active'
    else
      ''
    end
  end

  def display_price(amount)
    number_to_currency(amount, :precision => 0, :unit => "ש\"ח", format: '%n%u')
  end

  def display_quantity(quantity, quantity_unit)
    quantity ? quantity.to_s + quantity_unit : nil
  end

  def display_item_quantity(item)
    if item.sellable_type == "EssentialOil"
      case item.package_type
        when '5ml'
          display_quantity(5, "מ\"ל")
        when '10ml'
          display_quantity(10, "מ\"ל")
        when '50ml'
          display_quantity(50, "מ\"ל")
      end 
    else
      case item.package_type
        when 'nurmal'
          display_quantity(item.sellable.quantity, item.sellable.quantity_unit)
        when 'medium'
          display_quantity(item.sellable.medium_package_price, item.sellable.quantity_unit)
        when 'big'
          display_quantity(item.sellable.big_package_quantity, item.sellable.quantity_unit)
      end        
    end
  end

  def display_date(date)
    #date.to_formatted_s(:long) 
    date.strftime("%d/%m/%Y %l:%M%P") unless !date # 03/14/2013 9:09pm 
  end

  def display_nutritional_data(product)
    string = \
    'אנרגיה ' + ActiveSupport::NumberHelper.number_to_rounded(product.energy, strip_insignificant_zeros: true).to_s + ' קק"ל' \
    + ', חלבון ' + ActiveSupport::NumberHelper.number_to_rounded(product.protein, strip_insignificant_zeros: true).to_s + ' גרם,' \
    + ' פחמימות ' + ActiveSupport::NumberHelper.number_to_rounded(product.carbohydrates, strip_insignificant_zeros: true).to_s + ' גרם,' \
    + ' שומן ' + ActiveSupport::NumberHelper.number_to_rounded(product.fat, strip_insignificant_zeros: true).to_s + ' גרם,' \
    + ' מתוכו שומן רווי ' + ActiveSupport::NumberHelper.number_to_rounded(product.saturated_fat, strip_insignificant_zeros: true).to_s + ' גרם,' \
    + ' כולסטרול ' + ActiveSupport::NumberHelper.number_to_rounded(product.cholesterol, strip_insignificant_zeros: true).to_s + ' גרם, ' \
    + 'נתרן ' + ActiveSupport::NumberHelper.number_to_rounded(product.sodium, strip_insignificant_zeros: true).to_s  + ' גרם' 
    if product.other_nutrients? 
      string += ', '
      string += product.other_nutrients 
    end
    string += '.'
    return string
  end

  def display_country(country_code)
    Carmen::Country.coded(country_code).name + ' (' + country_code + ')'
  end

  def display_state(country_code, state_code)
    if state_code && Carmen::Country.coded(country_code) && Carmen::Country.coded(country_code).subregions.coded(state_code)
      Carmen::Country.coded(country_code).subregions.coded(state_code).name + ' (' + state_code + ')'
    else
      state_code
    end
  end

  def address_form_url_by_zone(zone)
    if zone == 'order'
      checkout_path
    elsif zone == 'address'
      nil
    end
  end

  def display_image_attribute(link)
    if link.include? "commons.wikimedia"
      'Wikimedia Commons.'
    elsif link.include? ".wikipedia"
      'Wikipedia.'
    else
      "Pixabay"
    end
  end

  def category(name)
    Category.find_by(name: name)
  end

  def display_post_mail_shipping_bill
    Order.post_mail_shipping_bill(shopping_cart.map{|item| Order.total_weight(item)}.inject(0, :+))
  end
end
