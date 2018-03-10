# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 4.1", require: false
  gem "bundler-audit", "~> 0.6", require: false
  gem "inch", "~> 0.8.0.rc2", require: false
  gem "listen", "~> 3.1", require: false
  gem "mdl", "~> 0.4", require: false
  gem "reek", "~> 4.7", require: false
  gem "rubocop", "~> 0.52", require: false
  gem "scss_lint", "~> 0.56", require: false
  gem "yard", "~> 0.9", require: false
end

group :development, :test do
  gem "pry-byebug", "~> 3.5"
  gem "sqlite3", ">= 1.3", platforms: %i[ruby mswin mswin64 mingw x64_mingw]
end

group :test do
  gem "capybara", "~> 2.17"
  gem "coveralls", "~> 0.8"
  gem "database_cleaner", "~> 1.6"
  gem "factory_bot_rails", "~> 4.8"
  gem "poltergeist", "~> 1.17"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails", "~> 3.7"
  gem "shoulda-callback-matchers", "~> 1.1"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", "~> 0.14"
end
