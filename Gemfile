source 'http://rubygems.org'
ruby "2.0.0"

gem 'rails', '3.2.13'

gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'redis'
gem 'redisable'
gem 'rspec-rails'
gem 'unicorn'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'thin'
  gem 'pry-nav'
  gem 'pry-doc'
  gem 'pry-rails'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
