source "https://rubygems.org"

# Frameworks
gem "rails", "4.2.5.1"
gem "kaminari", "~> 1.0.1"

# DB
gem "pg", "~> 0.18.4"
gem "gdal", "~> 1.0.0"

# Frontend
gem "sass-rails", "~> 5.0"
gem "bower-rails", "~> 0.11.0"
gem "uglifier", ">= 1.3.0"
gem "browserify-rails", "~> 3.2.0"
gem "jquery-rails"

# Authentication
gem "devise", "~> 4.1.0"
gem "bcrypt", "~> 3.1.7"

# Testing
gem "mocha", "~> 1.1.0"
gem "factory_girl", "~> 4.7.0"

# Configuration and deployment
gem "dotenv-rails", "~> 2.1.1", :require => "dotenv/rails-now"

# Background tasks
gem "sidekiq", "~> 4.1.2"
gem "aws-sdk", "~> 2"
gem "sidetiq", "~> 0.7.0"

group :development, :test do
  gem "byebug"
end

group :development do
  gem "web-console", "~> 2.0"
  gem "capistrano", "3.6", require: false
  gem "capistrano-rails",   "~> 1.1", require: false
  gem "capistrano-bundler", "~> 1.1.4", require: false
  gem "capistrano-rvm",   "~> 0.1", require: false
  gem "capistrano-maintenance", "~> 1.0", require: false
  gem "capistrano-passenger", "~> 0.2.0", require: false
  gem "capistrano-npm"
  gem "capistrano-sidekiq"
end


