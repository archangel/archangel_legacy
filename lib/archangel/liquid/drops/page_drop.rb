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
        attributes :title, :path, :meta_keywords, :meta_description,
                   :published_at

        # Page id as a string
        #
        # @return [String] the id
        #
        def id
          object.id.to_s
        end
      end
    end
  end
end
