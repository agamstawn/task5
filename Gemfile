source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
gem 'pg', '~> 0.17.1'
# ===========================================searching==========================
gem 'pg_search'
# gem 'sqlite3'
gem 'thinking-sphinx', '~> 3.1.0', group: "production"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# ======================================recently=============================
gem 'bootstrap-sass', '~> 3.3.6'
# ============================================================================
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# ======================================export/import xls=====================
gem 'axlsx', '~> 2.0', '>= 2.0.1'

gem 'axlsx_rails'

gem 'acts_as_xlsx'

gem 'roo', '~> 2.3', '>= 2.3.2'

gem "iconv", "~> 1.0.3"
# ======================================paging==================================
gem 'kaminari'

gem 'will_paginate', '~> 3.0.6'

gem 'will_paginate-bootstrap'
# 
gem 'nested_form'
# ======================================md5======================================
gem 'bcrypt'

gem 'rubyzip', '~> 1.2'

gem 'roo-xls'
#=======================================test sidekiq==============================
gem 'sidekiq'
gem 'sinatra', require: false

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

ruby "2.2.3"

    # gem 'rails_12factor', group: "production"

gem 'thin'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # gem 'pry-rails'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

