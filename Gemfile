# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 4.6", require: false
  gem "erb_lint", "~> 0.0.29", require: false
  gem "inch", "~> 0.8", require: false
  gem "listen", "~> 3.1", require: false
  gem "mdl", "~> 0.5", require: false
  gem "reek", "~> 5.4", require: false
  gem "rubocop", "~> 0.74", require: false
  gem "rubocop-performance", "~> 1.4", require: false
  gem "rubocop-rails", "~> 2.3", require: false
  gem "rubocop-rspec", "~> 1.35", require: false
  gem "yard", "~> 0.9", require: false
end

group :development, :test do
  gem "pg", "~> 1.1"
  gem "pry-byebug", "~> 3.7"
  gem "sqlite3", "~> 1.4.1"
end

group :test do
  gem "json-schema", "~> 2.8", require: false
  gem "launchy", "~> 2.4", require: false
  gem "simplecov", "~> 0.17", require: false
  gem "timecop", "~> 0.9", require: false
  gem "webdrivers", "~> 4.1", require: false

  # Shared, general purpose gems
  gem "capybara", "~> 3.28"
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot_rails", "~> 5.0"
  gem "rspec-rails", "~> 3.8"
  gem "shoulda-matchers", "~> 4.1"
end
