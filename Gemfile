# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 4.3", require: false
  gem "erb_lint", "~> 0.0.28", require: false
  gem "inch", "~> 0.8", require: false
  gem "listen", "~> 3.1", require: false
  gem "mdl", "~> 0.5", require: false
  gem "reek", "~> 5.2", require: false
  gem "rubocop", "~> 0.59", require: false
  gem "yard", "~> 0.9", require: false
end

group :development, :test do
  gem "pg", "~> 1.1"
  gem "pry-byebug", "~> 3.6"
  gem "sqlite3", "~> 1.3.6"
end

group :test do
  gem "simplecov", "~> 0.16", require: false

  gem "capybara", "~> 3.8"
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot_rails", "~> 4.11"
  gem "poltergeist", "~> 1.18"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails", "~> 3.8"
  gem "shoulda-callback-matchers", "~> 1.1"
  gem "shoulda-matchers", "~> 3.1"
end
