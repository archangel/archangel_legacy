# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Archangel custom Liquid tags
    #
    module Tags
      ##
      # Base helper class for Liquid
      #
      class ApplicationTag < ::Liquid::Tag
        include ::ActionView::Helpers::TagHelper

        ##
        # Regex for asset name
        #
        ASSET_SYNTAX = /
          #{::Liquid::QuotedString}
          |
          (
            [\w-]+\.[\w]+
            |
            #{::Liquid::QuotedString}
          )
        /ox

        ##
        # Regex for tag syntax
        #
        ASSET_ATTRIBUTES_SYNTAX = /
          (?<asset>#{ASSET_SYNTAX})
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # Regex for "key: value" attributes
        #
        # Example
        #   {% tag_name "[slug]" [foo: bar, bat: "baz"] %}
        #
        KEY_VALUE_ATTRIBUTES_SYNTAX = /
          (?<key>\w+)
          \s*
          \:
          \s*
          (?<value>#{::Liquid::QuotedFragment})
        /ox

        ##
        # Slug and attributes syntax
        #
        # Example
        #   {% tag_name "[slug]" [attributes] %}
        #
        SLUG_ATTRIBUTES_SYNTAX = /
          (?<slug>#{::Liquid::QuotedFragment}+)
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # Slug syntax
        #
        # Example
        #   {% tag_name "[slug]" %}
        #
        SLUG_SYNTAX = /(?<slug>#{::Liquid::QuotedFragment}+)\s*/o

        ##
        # URL and attributes syntax
        #
        # Example
        #   {% tag_name "[url]" [attributes] %}
        #
        URL_ATTRIBUTES_SYNTAX = /
          (?<url>#{::Liquid::QuotedFragment}+)
          \s*
          (?<attributes>.*)
          \s*
        /omx
      end
    end
  end
end
