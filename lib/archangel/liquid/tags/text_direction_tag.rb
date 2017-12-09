# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class TextDirectionTag < ::Liquid::Tag
        def render(context)
          context.registers[:view].text_direction
        end
      end
    end
  end
end

::Liquid::Template.register_tag("text_direction",
                                Archangel::Liquid::Tags::TextDirectionTag)
