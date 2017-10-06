# frozen_string_literal: true

module Archangel
  class AssetUploader < ApplicationUploader
    version :small, if: :image_format? do
      process resize_to_fill: [64, 64]
    end

    version :tiny, from_version: :small, if: :image_format? do
      process resize_to_fill: [32, 32]
    end

    def extension_whitelist
      %w[css gif jpeg jpg js png]
    end

    def default_path
      "archangel/fallback/" + [version_name, "asset.png"].compact.join("_")
    end

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
