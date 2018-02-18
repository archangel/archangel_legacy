# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Archangel custom Liquid filters
    #
    module Filters
      ##
      # Link custom filters for Liquid
      #
      module LinkToFilter
        ##
        # link_to a string
        #
        # Example
        #   {{ "Some text" | link_to: "https://example.com" }}
        #     # => "<a href="https://example.com">Some text</a>"
        #
        # @param link_text [String] string to link
        # @return [String] the link
        #
        def link_to(link_text, *args)
          link = args.first

          return link_text if link.blank?

          "<a href=\"#{link}\">#{link_text}</a>"
        end
      end
    end
  end
end

::Liquid::Template.register_filter(Archangel::Liquid::Filters::LinkToFilter)
