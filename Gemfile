source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sassc', '~> 2.4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'pwned', '~> 2.0.0'

gem 'jbuilder', '~> 2.10.0'

gem 'sprockets', '~> 4.0'
gem 'sprockets-rails', :require => 'sprockets/railtie'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', require: false
  gem 'rubocop', '>= 0.72', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'scss_lint', '~> 0.50', require: false
  gem 'brakeman', '>= 4.0', require: false
  gem 'benchmark-ips', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'web-console'
  gem 'faker', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
