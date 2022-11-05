source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Store nested hashes in hstores in ActiveRecord
gem 'nested-hstore'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
gem 'rswag'
gem 'rswag-api'
gem 'rswag-ui'

# Simple, efficient background processing for Ruby
gem "sidekiq"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Create pretty URLs
gem 'friendly_id', '~> 5.4.0'

# Pagination
gem 'kaminari'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# AASM - State machines
gem 'aasm'

# Authentication
gem "devise"
gem "jwt"

# Enumerated attributes
gem 'enumerize'

# Code coverage analysis tool
gem 'simplecov', require: false, group: :test

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # Unit test for Rails
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rswag-specs'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'main'

  # Kill N+1 queries and unused eager loading
  gem 'bullet'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Enforcing Rails best practices and coding conventions
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # Add EXPLAIN ANALYZE to Rails Active Record query objects
  gem 'activerecord-analyze'
end
