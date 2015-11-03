CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :aws
    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region:            'eu-central-1'
      #config: AWS.config({s3_endpoint: "eu-central-1.amazonaws.com"})
    }
    config.host_name => 'eu-central-1.amazonaws.com',
    config.aws_bucket  = ENV.fetch('S3_BUCKET')
    config.aws_acl    = 'public-read'
  
    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  
    # Set custom options such as cache control to leverage browser caching
    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end


