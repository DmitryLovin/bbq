source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "bootsnap", require: false
gem "devise"
gem "importmap-rails"
gem "jquery-rails"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "therubyrhino"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "twitter-bootstrap-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
end

group :production do
  gem "pg"
end
