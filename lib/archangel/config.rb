# frozen_string_literal: true

module Archangel
  ##
  # Application configurations
  #
  class Config < Anyway::Config
    config_name :archangel

    attr_config allow_registration: false,
                asset_maximum_file_size: 2.megabytes,
                asset_extension_whitelist: %i[gif jpeg jpg png],
                auth_path: "account",
                backend_path: "backend",
                favicon_extension_whitelist: %i[gif ico jpeg jpg png],
                favicon_maximum_file_size: 2.megabytes,
                frontend_path: "",
                image_extension_whitelist: %i[gif jpeg jpg png],
                image_maximum_file_size: 2.megabytes

    def keys_in(keys)
      to_h.select { |key| keys.include?(key) }
    end
  end
end
