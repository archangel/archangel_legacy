# frozen_string_literal: true

require "shoulda-matchers"
require "shoulda-callback-matchers"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end
