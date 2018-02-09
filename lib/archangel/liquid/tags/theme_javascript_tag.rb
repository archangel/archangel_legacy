# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Theme Javascript custom tag for Liquid
      #
      # Example
      #   {% theme_javascript %}
      #
      class ThemeJavascriptTag < ApplicationTag
        ##
        # Render the Javascript for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the Javascript for the theme
        #
        def render(context)
          view = context.registers[:view]

          view.javascript_include_tag("#{view.current_theme}/frontend")
        end
      end
    end
  end
end

::Liquid::Template.register_tag("theme_javascript",
                                Archangel::Liquid::Tags::ThemeJavascriptTag)
