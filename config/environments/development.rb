Rails.application.configure do
 
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  #config.after_initialize do
  #  ActiveMerchant::Billing::Base.mode = :test  # :production when you will use a real Pro Account
  #  ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
  #    login: "maya166-facilitator_api1.gmail.com",
  #    password: "C4XN7E5G6CNZQESA",
  #    signature: "An5ns1Kso7MWUdW4ErQKJJJ4qi4-AKIVZ133xNQEyKKDhPqt.82GDwTb"
  #  )
  #end

end
