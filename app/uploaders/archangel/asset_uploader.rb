# frozen_string_literal: true

module Archangel
  ##
  # Asset uploader
  #
  class AssetUploader < ApplicationUploader
    version :small, if: :image_format? do
      process resize_to_fit: [64, 64]
    end

    version :tiny, from_version: :small, if: :image_format? do
      process resize_to_fit: [32, 32]
    end

    ##
    # File extension whitelist
    #
    # @return [Array] file extension whitelist
    #
    def extension_whitelist
      Archangel.config.asset_extension_whitelist
    end

    ##
    # Uploaded path for file
    #
    # @return [String] upload path
    #
    def default_path
      "archangel/fallback/" + [version_name, "asset.png"].compact.join("_")
    end

    ##
    # Uploaded file name
    #
    # @return [String] randomly generated file name
    #
    def filename
      "#{secure_token}.#{file.extension}" if original_filename.present?
    end

    protected

    def secure_token
      secure_var = :"@#{mounted_as}_secure_token"

      model.instance_variable_get(secure_var) ||
        model.instance_variable_set(secure_var, SecureRandom.uuid)
    end
  end
end
