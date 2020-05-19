source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop-rails', '~> 2.5.2', require: false
  gem 'rubocop-rspec', '~> 1.39.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails', '~> 5.2.0'
  gem 'shoulda-matchers', '~> 4.3.0'
end

gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
