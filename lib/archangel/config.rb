# frozen_string_literal: true

module Archangel
  ##
  # Application configurations
  #
  class Config < Anyway::Config
    config_name :archangel

    attr_config asset_maximum_file_size: 2.megabytes,
                asset_extension_whitelist: %w[gif jpeg jpg png],
                auth_path: "account",
                backend_path: "backend",
                frontend_path: "",
                image_extension_whitelist: %w[gif jpeg jpg png],
                image_maximum_file_size: 2.megabytes

    ##
    # Return a blog of key/values as a hash
    #
    # Example
    #   Archangel.config.keys_in([:foo, :bat]) => { foo: "bar", bat: "baz" }
    #
    # @param keys [Array] array of keys to find key/values for
    # @return [Hash] key/value hash
    #
    def keys_in(keys)
      to_h.select { |key| keys.include?(key) }
    end
  end
end
