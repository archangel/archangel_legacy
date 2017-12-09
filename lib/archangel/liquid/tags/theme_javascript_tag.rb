# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class ThemeJavascriptTag < ::Liquid::Tag
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
