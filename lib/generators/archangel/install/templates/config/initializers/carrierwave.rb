# frozen_string_literal: true

CarrierWave.configure do |config|
  # Local file storage
  config.storage = :file

  # Want to use upload files to AWS S3? Take a look at Carrierwave documentation
  # https://github.com/carrierwaveuploader/carrierwave#fog

  # Use local file storage for tests
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
