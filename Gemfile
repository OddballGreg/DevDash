# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.1'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'devise'
gem 'dotenv-rails'
gem 'draper'
gem 'jquery-rails'
gem 'redis', '~> 4.0'
gem 'ruby-trello'
gem 'sidekiq'
gem 'slim-rails'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

group :development do
  gem 'annotate', require: false
  gem 'fasterer', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails_best_practices', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubycritic', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
