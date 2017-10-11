# frozen_string_literal: true

module Archangel
  module ThemableConcern
    extend ActiveSupport::Concern

    module ClassMethods
      def theme(theme, options = {})
        @_theme = theme
        @_theme_options = options

        Archangel::Theme::ThemableController.apply_theme(self, theme, options)
      end
    end
  end
end
