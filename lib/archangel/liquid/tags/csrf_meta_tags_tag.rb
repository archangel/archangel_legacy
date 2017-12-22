# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Archangel custom Liquid tags
    #
    module Tags
      ##
      # CSRF meta tag custom tag for Liquid
      #
      # Example
      #   {% csrf_meta_tags %}
      #
      class CsrfMetaTagsTag < ::Liquid::Tag
        ##
        # Render the CSRF meta tags for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the CSRF meta tags
        #
        def render(context)
          context.registers[:view].csrf_meta_tags
        end
      end
    end
  end
end

::Liquid::Template.register_tag("csrf_meta_tags",
                                Archangel::Liquid::Tags::CsrfMetaTagsTag)
