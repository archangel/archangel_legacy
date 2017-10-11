# frozen_string_literal: true

require "factory_girl_rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start

      FactoryGirl.lint traits: true
    ensure
      DatabaseCleaner.clean
    end
  end
end
