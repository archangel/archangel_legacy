# frozen_string_literal: true

module Archangel
  module Liquid
    module Drops
      class SiteDrop < Archangel::Liquid::Drop
        attributes :name, :theme, :locale, :meta_keywords, :meta_description

        def favicon
          object.favicon.url
        end

        def logo
          object.logo.url
        end

        def logo_large
          object.logo.large.url
        end

        def logo_medium
          object.logo.medium.url
        end

        def logo_small
          object.logo.small.url
        end

        def logo_tiny
          object.logo.tiny.url
        end
      end
    end
  end
end
