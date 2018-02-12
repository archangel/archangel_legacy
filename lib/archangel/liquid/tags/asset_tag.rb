# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Asset custom tag for Liquid
      #
      # Example
      #   {% asset 'my-asset.png' %} #=>
      #     <img src="path/to/my-asset.png" alt="my-asset.png">
      #   {% asset 'my-asset.png' alt:'My image' class:'center' %} #=>
      #     <img src="path/to/my-asset.png" alt="My image" class="center">
      #
      class AssetTag < ApplicationTag
        ##
        # {% asset 'key' attributes %}
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
        # {% asset 'key' attributes %}
        #
        SYNTAX = /
          (?<key>#{KEY_SYNTAX})
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # {% asset 'key' attributes %}
        #
        SYNTAX_ATTRIBUTES = /
          (?<key>\w+)
          \s*
          \:
          \s*
          (?<value>#{::Liquid::QuotedFragment})
        /ox

        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.asset")
          end

          @key = ::Liquid::Variable.new(match[:key], options).name
          @attributes = {}

          match[:attributes].scan(SYNTAX_ATTRIBUTES) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the Asset
        #
        # @param context [Object] the Liquid context
        # @return [String] the rendered Asset
        #
        def render(context)
          return if key.blank?

          environments = context.environments[0]
          asset = load_asset_for(environments["site"])

          return if asset.blank?

          asset_decider(asset)
        end

        protected

        attr_reader :attributes, :key

        def load_asset_for(site)
          site.assets.find_by!(file_name: key)
        rescue StandardError
          nil
        end

        def asset_decider(asset)
          return unless %r{image/[gif|jpeg|jpg|png]} =~ asset.content_type

          image_asset(asset)
        end

        def image_asset(asset)
          params = {
            alt: asset.file_name
          }.merge(attributes).merge(
            src: asset.file.url
          ).compact.reject { |_, value| value.blank? }

          tag("img", params)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("asset", Archangel::Liquid::Tags::AssetTag)
