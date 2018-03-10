# frozen_string_literal: true

require "carrierwave/test/matchers"

RSpec.configure do |config|
  include ActionDispatch::TestProcess

  config.include CarrierWave::Test::Matchers, type: :uploader

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end
end
