source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

gem 'bootstrap-sass', '2.0.0'

gem 'bcrypt-ruby', '3.1.2'

gem 'faker', '1.0.1'

gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.6'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'rspec-rails', '>= 3.0.0'
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
end

group :development do

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  gem 'guard-rspec', '0.5.5'
  gem 'annotate', '~> 2.4.1.beta'
end

group :test do
  gem 'capybara', '>= 1.1.2'
  gem 'rb-fsevent', '0.9.4', :require => false
  gem 'growl', '1.0.3'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.4.0'
end

group :production do
  gem 'pg', '>= 0.12.2'
end
