source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.4'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'redis', '~> 4.0.1'
gem 'config'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
end

group :test do
  gem 'rspec', '~> 3.7'
  gem 'rspec-rails', '~> 3.7'
  gem 'rails-controller-testing'
  gem 'timecop'
  gem 'simplecov', require: false
end
