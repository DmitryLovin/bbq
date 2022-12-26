if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials[:aws_secret_access_key],
      region: 'eu-central-1'
    }

    config.fog_directory = Rails.application.credentials[:aws_bucket_name]
    config.fog_public = false
  end
end
