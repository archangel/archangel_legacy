# frozen_string_literal: true

module Archangel
  ##
  # Flash message helpers
  #
  module FlashHelper
    ##
    # Converts Rails flash message type to Bootstrap flash message type
    #
    # @param flash_type [String,Symbol] the flash message type
    # @return [String] flash message type
    def flash_class_for(flash_type)
      flash_type = flash_type.to_s.downcase.parameterize

      {
        success: "success", error: "danger", alert: "warning", notice: "info"
      }[flash_type.to_sym] || flash_type
    end
  end
end
