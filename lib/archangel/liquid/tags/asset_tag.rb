# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Asset custom tag for Liquid
      #
      # Example
      #   {% asset "my-asset.png" %} #=>
      #     <img src="path/to/my-asset.png" alt="">
      #   {% asset "my-asset.png" alt="My image" class="center" %}
      #     <img src="path/to/my-asset.png" alt="My image" class="center">
      #
      class AssetTag < BaseTag
        attr_reader :asset_name, :asset_params

        def initialize(tag_name, params, tokens)
          super

          @asset_name, @asset_params = key_with_params(params)
        end

        ##
        # Render the Asset
        #
        # @param context [Object] the Liquid context
        # @return [String] the rendered Asset
        #
        def render(context)
          return if asset_name.blank?

          environments = context.environments[0]
          asset = load_asset_for(environments["site"])

          return if asset.blank?

          asset_decider(asset)
        end

        protected

        def key_with_params(params)
          matches = /\s*(["|'])?([\w-]+\.[\w]+)\1?\s*(.*)/.match(params)

          [matches[2], attribute_string_to_hash(matches[3])]
        end

        def load_asset_for(site)
          site.assets.find_by!(file_name: asset_name)
        rescue StandardError
          nil
        end

        def asset_decider(asset)
          return unless %r{image/[gif|jpeg|jpg|png]} =~ asset.content_type

          image_asset(asset)
        end

        def image_asset(asset)
          attributes = { alt: asset.file_name }.merge(asset_params).merge(
            src: asset.file.url
          )

          tag("img", attributes)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("asset", Archangel::Liquid::Tags::AssetTag)
