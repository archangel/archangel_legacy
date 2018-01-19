# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Locale custom tag for Liquid
      #
      # Example
      #   {% locale %} #=> "en"
      #
      class LocaleTag < BaseTag
        ##
        # Render the locale for the theme
        #
        # @param context [Object] the Liquid context
        # @return [String] the locale
        #
        def render(context)
          context.registers[:view].locale
        end
      end
    end
  end
end

::Liquid::Template.register_tag("locale", Archangel::Liquid::Tags::LocaleTag)
