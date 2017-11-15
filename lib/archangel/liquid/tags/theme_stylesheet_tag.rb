# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class ThemeStylesheetTag < ::Liquid::Tag
        def render(context)
          current_theme = context.registers[:view].current_theme
          style = "#{current_theme}/frontend"

          context.registers[:view].stylesheet_link_tag(style)
        end
      end
    end
  end
end

::Liquid::Template.register_tag "theme_stylesheet",
                                Archangel::Liquid::Tags::ThemeStylesheetTag
