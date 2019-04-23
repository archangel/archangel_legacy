# frozen_string_literal: true

require "timecop"

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers

  config.before do
    Timecop.freeze
  end

  config.after do
    Timecop.return
  end
end
