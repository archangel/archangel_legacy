# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # CSRF meta tag custom tag for Liquid
      #
      # Example
      #   {% csrf_meta_tags %}
      #
      class CsrfMetaTagsTag < ApplicationTag
        ##
        # Render the CSRF meta tags for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the CSRF meta tags
        #
        # :reek:UtilityFunction
        def render(context)
          context.registers[:view].csrf_meta_tags
        end
      end
    end
  end
end

::Liquid::Template.register_tag("csrf_meta_tags",
                                Archangel::Liquid::Tags::CsrfMetaTagsTag)
