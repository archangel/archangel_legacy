# frozen_string_literal: true

require "timecop"

RSpec.configure do |config|
  config.after { Timecop.return }
end
