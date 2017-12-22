# frozen_string_literal: true

module Archangel
  ##
  # Favicon uploader
  #
  class FaviconUploader < ApplicationUploader
    process resize_to_fill: [32, 32]
    process convert: :ico

    ##
    # Uploaded path for file
    #
    # @return [String] upload path
    #
    def default_path
      "archangel/fallback/" + [version_name, "favicon.ico"].compact.join("_")
    end

    ##
    # File extension whitelist
    #
    # @return [Array] file extension whitelist
    #
    def extension_whitelist
      Archangel.config.favicon_extension_whitelist
    end

    ##
    # Uploaded file name
    #
    # @return [String] file name
    #
    def filename
      "favicon.ico" if original_filename.present?
    end
  end
end
