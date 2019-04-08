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
        include ::ActionView::Helpers::UrlHelper

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
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.asset")
          end

          @key = ::Liquid::Variable.new(match[:asset], options).name
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
          attrs.scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
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
          if %r{image/[gif|jpeg|png]}.match?(asset.content_type)
            image_asset(asset)
          else
            linked_asset(asset)
          end
        end

        def image_asset(asset)
          params = {
            alt: asset.file_name
          }.merge(attributes).merge(
            src: sized_image_asset(asset.file)
          ).compact.reject { |_, value| value.blank? }

          tag("img", params)
        end

        def linked_asset(asset)
          options = attributes.compact.reject { |_, value| value.blank? }

          link_to(asset.file_name, asset.file.url, options)
        end

        def sized_image_asset(file)
          size.blank? ? file.url : file.send(size).url
        end
      end
    end
  end
end

::Liquid::Template.register_tag("asset", Archangel::Liquid::Tags::AssetTag)
