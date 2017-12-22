# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Text direction custom tag for Liquid
      #
      # Example
      #   {% text_direction %} #=> "ltr"
      #
      class TextDirectionTag < ::Liquid::Tag
        ##
        # Render the text direction for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the text direction
        #
        def render(context)
          context.registers[:view].text_direction
        end
      end
    end
  end
end

::Liquid::Template.register_tag("text_direction",
                                Archangel::Liquid::Tags::TextDirectionTag)
