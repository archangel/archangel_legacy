# frozen_string_literal: true

module Archangel
  class FaviconUploader < ApplicationUploader
    process resize_to_fill: [32, 32]
    process convert: :ico

    def default_path
      "archangel/fallback/" + [version_name, "favicon.ico"].compact.join("_")
    end

    def extension_whitelist
      Archangel.config.favicon_extension_whitelist
    end

    def filename
      "favicon.ico" if original_filename.present?
    end
  end
end
