if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = "fog/aws"

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials[:aws_secret_access_key]
    }

    config.fog_directory  = Rails.application.credentials[:aws_bucket_name]
  end
end
