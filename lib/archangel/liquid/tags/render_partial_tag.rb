# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Theme partial custom tag for Liquid
      #
      # Example
      #   {% render_partial "theme/partial" %}
      #   {% render_partial "theme/partial" param='value' param2="value" %}
      #
      class RenderPartialTag < ApplicationTag
        def initialize(tag_name, param, tokens)
          super

          @partial_name = param.gsub(/\s|"|'/, "")
        end

        ##
        # Render a partial for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the partial
        #
        def render(context)
          context.registers[:controller]
                 .render_to_string(partial: @partial_name)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("render_partial",
                                Archangel::Liquid::Tags::RenderPartialTag)
