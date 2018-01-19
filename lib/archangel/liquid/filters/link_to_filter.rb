# frozen_string_literal: true

module Archangel
  module Liquid
    module Filters
      ##
      # link_to custom filter for Liquid
      #
      module LinkToFilter
        include ActionView::Helpers::UrlHelper

        ##
        # link_to a string
        #
        # Example
        #   {{ "Some text" | link_to "https://example.com" }}
        #     # => "<a href="https://example.com">Some text</a>"
        #
        # @param input [String] string to titleize
        # @return [String] the titleized string
        #
        def link_to(anchor, *args)
          link_to(args.first, anchor)
        end
      end
    end
  end
end

::Liquid::Template.register_filter(Archangel::Liquid::Filters::LinkToFilter)
