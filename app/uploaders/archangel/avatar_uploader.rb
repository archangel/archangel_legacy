# frozen_string_literal: true

module Archangel
  class AvatarUploader < ApplicationUploader
    process resize_to_fit: [512, 512]

    version :large do
      process resize_to_fill: [256, 256]
    end

    version :medium, from_version: :large do
      process resize_to_fill: [128, 128]
    end

    version :small, from_version: :medium do
      process resize_to_fill: [64, 64]
    end

    version :tiny, from_version: :small do
      process resize_to_fill: [32, 32]
    end

    def default_path
      "archangel/fallback/" + [version_name, "avatar.jpg"].compact.join("_")
    end

    def filename
      "avatar.#{file.extension}" if original_filename.present?
    end
  end
end
