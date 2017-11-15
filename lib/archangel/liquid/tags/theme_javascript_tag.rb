# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class ThemeJavascriptTag < ::Liquid::Tag
        def render(context)
          current_theme = context.registers[:view].current_theme
          script = "#{current_theme}/frontend"

          context.registers[:view].javascript_include_tag(script)
        end
      end
    end
  end
end

::Liquid::Template.register_tag "theme_javascript",
                                Archangel::Liquid::Tags::ThemeJavascriptTag
