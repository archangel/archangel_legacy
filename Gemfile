# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 4.0.1", require: false
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "reek", "~> 4.7.2", require: false
  gem "rubocop", "~> 0.51.0", require: false
  gem "scss_lint", "~> 0.56.0", require: false
end

group :development, :test do
  gem "pry-byebug", "~> 3.5.0"
  gem "sqlite3", ">= 1.3.0", platforms: %i[ruby mswin mswin64 mingw x64_mingw]
end

group :test do
  gem "capybara", "~> 2.16.1"
  gem "database_cleaner", "~> 1.6.1"
  gem "factory_bot_rails", "~> 4.8.2"
  gem "poltergeist", "~> 1.16.0"
  gem "rails-controller-testing", "~> 1.0.2"
  gem "rspec-rails", "~> 3.7.2"
  gem "shoulda-callback-matchers", "~> 1.1.4"
  gem "shoulda-matchers", "~> 3.1.2"
  gem "simplecov", "~> 0.15.1"
end
