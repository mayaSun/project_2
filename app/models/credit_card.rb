module CreditCard 

  class Charge 
 
    attr_accessor :card_brand, :card_number, :card_verification, :card_expires_month, :card_expires_year, :first_name, :last_name, :ip_address, :credit_card
    attr_accessor :errors

    def initialize(params = {})
      @card_brand = params[:card_brand]
      @card_number = params[:card_number] 
      @card_verification = params[:card_verification] 
      @card_expires_month = params["card_expires_on(2i)"]
      @card_expires_year = params["card_expires_on(1i)"]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @ip_address = params[:ip_address]
      @errors = []
      @credit_card = nil
      validate_card
    end

    def purchase(price)
      response = GATEWAY.purchase(price_in_cents(price), credit_card, purchase_options)
      response.success?
      response.message
    end

    def price_in_cents(price)
      (price*100).round
    end

    private

    def purchase_options
      {
          ip: ip_address,
          billing_address: {
              name:      "Flaying Cakes",
              address1:  "123 5th Av.",
              city:      "New York",
              state:     "NY",
              country:   "US",
              zip:       "10001"
          }
      }
    end

    def validate_card
      unless credit_card.valid?
        @credit_card.errors.full_messages.each do |message|
          @errors << message
        end
      end
    end

    def credit_card
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        brand:               @card_brand,
        number:              @card_number,
        verification_value:  @card_verification,
        month:               @card_expires_month,
        year:                @card_expires_year,
        first_name:          @first_name,
        last_name:           @last_name
      )
    end

  end

end 
