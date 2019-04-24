# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Controller theme concern
    #
    module ThemableConcern
      extend ActiveSupport::Concern

      ##
      # ThemableConcern class methods
      #
      module ClassMethods
        ##
        # Converts the object into textual markup given a specific format.
        #
        # @param theme [String,Symbol,Proc] the theme
        # @param options [Hash] the theme options
        # @return [Object] the theme object
        #
        def theme(theme, options = {})
          @_theme = theme
          @_theme_options = options

          Archangel::Theme::ThemableController.apply_theme(self, theme, options)
        end
      end
    end
  end
end
