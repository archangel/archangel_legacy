# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Gist custom tag for Liquid
      #
      # Example
      #   {% gist '9bbaf7332bff1042c2d83fc88683b9df' %}
      #   {% gist '9bbaf7332bff1042c2d83fc88683b9df' file:'hello.rb' %}
      #
      class GistTag < ApplicationTag
        include ::ActionView::Helpers::AssetTagHelper

        ##
        # Regex for tag key
        #
        KEY_SYNTAX = /
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
        SYNTAX = /
          (?<key>#{KEY_SYNTAX})
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # Regex for attributes
        #
        SYNTAX_ATTRIBUTES = /
          (?<key>\w+)
          \s*
          \:
          \s*
          (?<value>#{::Liquid::QuotedFragment})
        /ox

        ##
        # Asset for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.gist")
          end

          @key = ::Liquid::Variable.new(match[:key], options).name
          @attributes = {}

          match[:attributes].scan(SYNTAX_ATTRIBUTES) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the Gist
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered Gist
        #
        def render(_context)
          return if key.blank?

          src =  gist_source(key, attributes.fetch(:file, nil))

          javascript_include_tag(src)
        end

        protected

        attr_reader :attributes, :key

        def gist_source(id, file)
          file_string = file.blank? ? nil : "?file=#{file}"

          "https://gist.github.com/#{id}.js#{file_string}"
        end
      end
    end
  end
end

::Liquid::Template.register_tag("gist", Archangel::Liquid::Tags::GistTag)
