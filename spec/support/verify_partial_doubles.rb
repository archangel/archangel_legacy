# frozen_string_literal: true

RSpec.configure do |config|
  %i[controller view].each do |type|
    config.around(:each, type: type) do |example|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = false
        example.run
        mocks.verify_partial_doubles = true
      end
    end
  end

  config.around(:each, disable: :verify_partial_doubles) do |example|
    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = false
      example.run
      mocks.verify_partial_doubles = true
    end
  end
end
