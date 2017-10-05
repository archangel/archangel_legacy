# frozen_string_literal: true

module Archangel
  module FlashHelper
    def flash_class_for(flash_type)
      flash_type = flash_type.to_s.downcase.parameterize

      {
        success: "success", error: "danger", alert: "warning", notice: "info"
      }[flash_type.to_sym] || flash_type
    end
  end
end
