source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass', '3.4.0'
gem 'bcrypt', '3.1.11'
gem 'font-awesome-rails', '>= 4.7.0.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot', "~> 4.0"
  gem 'rails-controller-testing', '>= 1.0.2'
end

group :development do
  gem 'web-console', '>= 3.6.2'
  gem 'listen', '>= 3.1.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'capybara', '>= 3.0.3', '< 4.0'
  gem 'selenium-webdriver', '>= 3.11.0'
  gem 'chromedriver-helper', '>= 1.2.0'
  gem 'simplecov', require: false
  gem 'simplecov-shield'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
