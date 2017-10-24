# frozen_string_literal: true

require "database_cleaner"

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    strategy = example.metadata[:js] ? :truncation : :transaction

    DatabaseCleaner.strategy = strategy
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
