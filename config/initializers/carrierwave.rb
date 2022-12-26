if Rails.env.production?
  secrets = YAML::load_file('config/secrets.yml')
  CarrierWave.configure do |config|
    config.fog_provider = "fog/aws"

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     secrets['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: secrets['AWS_SECRET_ACCESS_KEY']
    }

    config.fog_directory  = secrets['AWS_BUCKET_NAME']
  end
end
