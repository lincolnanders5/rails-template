source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sassc', '~> 2.4'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1'
gem 'devise', '~> 4.7'
gem 'devise-pwned_password', '~> 0.1.4'

gem 'jbuilder', '~> 2.10'

gem 'sprockets', '~> 4.0'
gem 'sprockets-rails', '~> 3.2', require: 'sprockets/railtie'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'benchmark-ips', require: false
  gem 'brakeman', '~> 4', require: false
  gem 'byebug', require: false
  gem 'rubocop', '~> 1.6', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'scss_lint', '~> 0.50', require: false

  gem 'better_errors', '~> 2.9.1', require: false
  gem 'binding_of_caller', '~> 0.8.0', require: false
end

group :development do
  gem 'faker', '~> 2.15.1', require: false
  gem 'listen', '~> 3.3'
  gem 'web-console', '~> 4.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
