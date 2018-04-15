# frozen_string_literal: true

module Archangel
  module Liquid
    module Drops
      ##
      # Liquid drop for a Site
      #
      class SiteDrop < Archangel::Liquid::Drop
        attributes :locale, :meta_description, :meta_keywords, :name

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
      end
    end
  end
end
