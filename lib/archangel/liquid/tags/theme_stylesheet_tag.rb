# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Theme stylesheet custom tag for Liquid
      #
      # Example
      #   {% theme_stylesheet %}
      #
      class ThemeStylesheetTag < ApplicationTag
        ##
        # Render the stylesheet for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the stylesheet for the theme
        #
        def render(context)
          view = context.registers[:view]

          view.stylesheet_link_tag("#{view.current_theme}/frontend")
        end
      end
    end
  end
end

::Liquid::Template.register_tag("theme_stylesheet",
                                Archangel::Liquid::Tags::ThemeStylesheetTag)
