# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 4.1.1", require: false
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "reek", "~> 4.7.3", require: false
  gem "rubocop", "~> 0.52.0", require: false
  gem "scss_lint", "~> 0.56.0", require: false
  gem "yard", "~> 0.9.12", require: false
end

group :development, :test do
  gem "pry-byebug", "~> 3.5.0"
  gem "sqlite3", ">= 1.3.0", platforms: %i[ruby mswin mswin64 mingw x64_mingw]
end

group :test do
  gem "capybara", "~> 2.16.1"
  gem "coveralls", "~> 0.8.21"
  gem "database_cleaner", "~> 1.6.2"
  gem "factory_bot_rails", "~> 4.8.2"
  gem "poltergeist", "~> 1.17.0"
  gem "rails-controller-testing", "~> 1.0.2"
  gem "rspec-rails", "~> 3.7.2"
  gem "shoulda-callback-matchers", "~> 1.1.4"
  gem "shoulda-matchers", "~> 3.1.2"
  gem "simplecov", "~> 0.14.1"
end
