# frozen_string_literal: true

module Archangel
  module Liquid
    module Drops
      ##
      # Liquid drop for a Site
      #
      class SiteDrop < Archangel::Liquid::Drop
        attributes :name, :theme, :locale, :meta_keywords, :meta_description

        # Site favicon URL
        #
        # @return [String] the Site favicon URL
        #
        def favicon
          object.favicon.url
        end

        # Original size Site logo URL
        #
        # @return [String] the original Site logo URL
        #
        def logo
          object.logo.url
        end

        # Large size Site logo URL
        #
        # @return [String] the large Site logo URL
        #
        def logo_large
          object.logo.large.url
        end

        # Medium size Site logo URL
        #
        # @return [String] the medium Site logo URL
        #
        def logo_medium
          object.logo.medium.url
        end

        # Small size Site logo URL
        #
        # @return [String] the small Site logo URL
        #
        def logo_small
          object.logo.small.url
        end

        # Tiny size Site logo URL
        #
        # @return [String] the tiny Site logo URL
        #
        def logo_tiny
          object.logo.tiny.url
        end
      end
    end
  end
end
