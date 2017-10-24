# frozen_string_literal: true

require "carrierwave/test/matchers"

RSpec.configure do |config|
  include ActionDispatch::TestProcess

  config.include CarrierWave::Test::Matchers, type: :uploader

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end
end

def uploader_test_image
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/image.gif"
end

def uploader_test_favicon
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/favicon.png"
end

def uploader_test_stylesheet
  Archangel::Engine.root +
    "lib/archangel/testing_support/fixtures/stylesheet.css"
end
