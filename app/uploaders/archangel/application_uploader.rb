# frozen_string_literal: true

module Archangel
  class ApplicationUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    def default_path
      "/images/fallback/" + [version_name, "default.jpg"].compact.join("_")
    end

    def extension_whitelist
      Archangel.config.image_extension_whitelist
    end

    def remove_animation
      manipulate!(&:collapse!) if content_type == "image/gif"
    end

    def image?
      image_formats.include?(file.content_type)
    end

    protected

    def image_formats
      %w[image/gif image/jpeg image/jpg image/png]
    end

    def image_format?(new_file)
      image_formats.include?(new_file.content_type)
    end
  end
end
