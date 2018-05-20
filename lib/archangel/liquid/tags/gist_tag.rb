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
        # Asset for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = ASSET_ATTRIBUTES_SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.gist")
          end

          @key = ::Liquid::Variable.new(match[:asset], options).name
          @attributes = {}

          match[:attributes].scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
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
