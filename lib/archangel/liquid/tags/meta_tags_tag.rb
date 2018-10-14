# frozen_string_literal: true

require "meta-tags"

module Archangel
  module Liquid
    module Tags
      ##
      # Meta tags custom tag for Liquid
      #
      # Example
      #   {% meta_tags %}
      #
      class MetaTagsTag < ApplicationTag
        ##
        # Render the meta tgas for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the meta tags
        #
        # :reek:UtilityFunction
        def render(context)
          context.registers[:view].display_meta_tags
        end
      end
    end
  end
end

::Liquid::Template.register_tag("meta_tags",
                                Archangel::Liquid::Tags::MetaTagsTag)
