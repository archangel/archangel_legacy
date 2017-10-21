# frozen_string_literal: true

module Archangel
  module Liquid
    module Drops
      class PageDrop < Archangel::Liquid::Drop
        attributes :title, :path, :meta_keywords, :meta_description,
                   :published_at

        def id
          object.id.to_s
        end
      end
    end
  end
end
