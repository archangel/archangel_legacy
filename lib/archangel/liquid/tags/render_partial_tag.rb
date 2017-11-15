# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class RenderPartialTag < ::Liquid::Tag
        def initialize(tag_name, partial_name, options)
          super

          @partial_name = partial_name.gsub(/\s|"|'/, "")
        end

        def render(context)
          context.registers[:controller]
                 .render_to_string(partial: @partial_name)
        end
      end
    end
  end
end

::Liquid::Template.register_tag "render_partial",
                                Archangel::Liquid::Tags::RenderPartialTag
