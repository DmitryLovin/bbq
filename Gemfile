source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "carrierwave"
gem "devise"
gem "devise-i18n"
gem "fog-aws"
gem "importmap-rails"
gem "mailjet"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-github"
gem "omniauth-rails_csrf_protection"
gem "puma", "~> 5.0"
gem "pundit"
gem "rails", "~> 7.0.4"
gem "rails-i18n"
gem "resque"
gem "rmagick"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-resque", require: false
  gem "ed25519"
  gem "bcrypt_pbkdf"
  gem "letter_opener"
end

group :production do
  gem "pg"
end

gem "jsbundling-rails", "~> 1.1"
