source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "carrierwave"
gem "cssbundling-rails", "~> 1.1"
gem "devise"
gem "devise-i18n"
gem "fog-aws"
gem "importmap-rails"
gem "mailjet"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4"
gem "rails-i18n"
gem "rmagick"
gem "sprockets-rails"
gem "twitter-bootstrap-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end

group :production do
  gem "pg"
end

gem "jsbundling-rails", "~> 1.1"
