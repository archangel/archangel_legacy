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
  Archangel::Engine.root + "spec/fixtures/image.gif"
end

def uploader_test_text
  Archangel::Engine.root + "spec/fixtures/text.txt"
end

def uploader_test_favicon
  Archangel::Engine.root + "spec/fixtures/favicon.png"
end
