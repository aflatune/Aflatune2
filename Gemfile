# Gem sources
source 'http://gemcutter.org'
source 'http://gems.github.com'

# Rails basics
gem 'rails', '3.0.0'
gem 'mysql'
gem 'bson_ext', '1.0.4'
gem 'redis'

# Rendering
gem 'haml'
gem 'formtastic', '~> 1.1.0'
gem 'unidecode'
gem 'hpricot'

# Authentication
gem 'warden', '>= 0.10.4'
gem 'devise', :git => "http://github.com/plataformatec/devise.git"
#gem 'oauth2'

gem 'mini_fb'

# Authorization
gem 'cancan'

# Performance
gem 'cache-with-yuicompressor'
gem 'memcached'
gem 'memcache-client'

# System
#gem 'request-log-analyzer'
#gem 'cpowell-SyslogLogger'

# Test only
group :test do
  gem 'rspec-rails', '>= 2.0.0.beta.10'
  gem 'factory_girl_rails'
end

group :cucumber do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails', '>= 2.0.0.beta.10'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end 

# Development only
group :development do
  gem 'rails3-generators'
  gem "haml-rails"
  gem "jquery-rails"
  gem 'capistrano'
  gem 'sqlite3-ruby', :require => 'sqlite3'
end
