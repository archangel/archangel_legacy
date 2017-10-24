# frozen_string_literal: true

CarrierWave.configure do |config|
  # Local file storage
  config.storage = :file

  # Want to use upload files to AWS S3? Take a look at Carrierwave documentation
  # https://github.com/carrierwaveuploader/carrierwave#fog
end
