# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Asset custom tag for Liquid
      #
      # Example
      #   {% asset 'my-asset.png' %} #=>
      #     <img src="path/to/my-asset.png" alt:"my-asset.png">
      #   {% asset 'my-asset.png' size:'medium' %} #=>
      #     <img src="path/to/medium_my-asset.png" alt:"my-asset.png">
      #   {% asset 'my-asset.png' alt:'My image' class:'center' %} #=>
      #     <img src="path/to/my-asset.png" alt="My image" class="center">
      #
      class AssetTag < ApplicationTag
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
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.asset")
          end

          @key = ::Liquid::Variable.new(match[:key], options).name
          @attributes = {}

          build_attributes(match[:attributes])
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

        attr_reader :attributes, :key, :size

        def build_attributes(attrs)
          attrs.scan(SYNTAX_ATTRIBUTES) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end

          size = attributes.fetch(:size, nil)

          @size = %w[small tiny].include?(size) ? size : nil
          @attributes.delete(:size)
        end

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
            src: sized_image_asset(asset.file)
          ).compact.reject { |_, value| value.blank? }

          tag("img", params)
        end

        def sized_image_asset(file)
          size.blank? ? file.url : file.send(size).url
        end
      end
    end
  end
end

::Liquid::Template.register_tag("asset", Archangel::Liquid::Tags::AssetTag)
