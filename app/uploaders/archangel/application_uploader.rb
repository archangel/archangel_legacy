# frozen_string_literal: true

module Archangel
  ##
  # Application base uploader
  #
  class ApplicationUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    ##
    # Storage path
    #
    # @return [String] path for file uploads
    #
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    ##
    # Base URL where uploaded files as accessed
    #
    # @return [String] base URL for file
    #
    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    ##
    # Uploaded path for file
    #
    # @return [String] upload path
    #
    def default_path
      "/images/fallback/" + [version_name, "default.jpg"].compact.join("_")
    end

    ##
    # File extension whitelist
    #
    # @return [Array] file extension whitelist
    #
    def extension_whitelist
      Archangel.config.image_extension_whitelist
    end

    ##
    # Remove all animation frames from GIF images
    #
    # @return [Object] first frame of GIF file
    #
    def remove_animation
      manipulate!(&:collapse!) if content_type == "image/gif"
    end

    ##
    # Check if file is an image based on file content_type
    #
    # @return [Boolean] if file is an image
    #
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
