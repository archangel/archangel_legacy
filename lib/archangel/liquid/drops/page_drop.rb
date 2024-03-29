# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Liquid drops for Archangel
    #
    module Drops
      ##
      # Liquid drop for a Page
      #
      class PageDrop < Archangel::Liquid::Drop
        attributes :published_at, :title

        # Page id as a string
        #
        # @return [String] the id
        #
        def id
          object.id.to_s
        end

        # Page permalink with leading slash
        #
        # @return [String] the permalink
        #
        def permalink
          "/#{object.permalink}"
        end
      end
    end
  end
end
