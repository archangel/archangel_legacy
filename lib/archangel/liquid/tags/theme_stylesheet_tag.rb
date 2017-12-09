# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class ThemeStylesheetTag < ::Liquid::Tag
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
