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
  gem "rubocop", "~> 0.67", require: false
  gem "yard", "~> 0.9", require: false
end

group :development, :test do
  gem "pg", "~> 1.1"
  gem "pry-byebug", "~> 3.6"
  gem "sqlite3", "~> 1.4.1"
end

group :test do
  gem "json-schema", "~> 2.8", require: false
  gem "launchy", "~> 2.4", require: false
  gem "simplecov", "~> 0.16", require: false
  gem "timecop", "~> 0.9", require: false

  gem "capybara", "~> 3.8"
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot_rails", "~> 5.0"
  gem "poltergeist", "~> 1.18"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails", "~> 3.8"
  gem "shoulda-callback-matchers", "~> 1.1"
  gem "shoulda-matchers", "~> 4.0"
end
