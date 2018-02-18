# frozen_string_literal: true

module Archangel
  ##
  # Avatar uploader
  #
  class AvatarUploader < ApplicationUploader
    process resize_to_fit: [512, 512]

    version :large do
      process resize_to_fit: [256, 256]
    end

    version :medium, from_version: :large do
      process resize_to_fit: [128, 128]
    end

    version :small, from_version: :medium do
      process resize_to_fit: [64, 64]
    end

    version :tiny, from_version: :small do
      process resize_to_fit: [32, 32]
    end

    ##
    # Uploaded path for file
    #
    # @return [String] upload path
    #
    def default_path
      "archangel/fallback/" + [version_name, "avatar.png"].compact.join("_")
    end

    ##
    # Uploaded file name
    #
    # @return [String] file name
    #
    def filename
      "avatar.#{file.extension}" if original_filename.present?
    end
  end
end
