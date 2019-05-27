# frozen_string_literal: true

require "factory_bot_rails"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start

    FactoryBot.lint traits: true
  ensure
    DatabaseCleaner.clean
  end
end
