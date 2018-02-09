# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Vimeo custom tag for Liquid
      #
      # Example
      #   Given the Vimeo URL https://vimeo.com/183344978
      #   {% vimeo "183344978" %}
      #   {% vimeo "183344978" width="800" height="600" %}
      #   {% vimeo "183344978" id="my_video" class="my-video" %}
      #   {% vimeo "183344978" autoplay="1" %}
      #   {% vimeo "183344978" loop="1" %}
      #   {% vimeo "183344978" allowfullscreen="0" %}
      #   {% vimeo "183344978" allowtransparency="0" %}
      #   {% vimeo "183344978" frameborder="4" %}
      #
      class VimeoTag < ApplicationTag
        attr_reader :vimeo_video_id, :vimeo_params

        def initialize(tag_name, params, tokens)
          super

          @vimeo_video_id, @vimeo_params = key_with_params(params)
        end

        ##
        # Render the Widget
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered Widget
        #
        def render(_context)
          return if vimeo_video_id.blank?

          content_tag(:iframe, "", video_attributes)
        end

        protected

        def video_attributes
          {
            id: vimeo_params.fetch(:id, nil),
            class: vimeo_params.fetch(:class, nil),
            style: vimeo_params.fetch(:style, nil),
            src: video_url,
            width: video_width,
            height: video_height,
            frameborder: vimeo_params.fetch(:frameborder, 0),
            allowtransparency: vimeo_params.fetch(:allowtransparency, "true"),
            allowFullScreen: vimeo_params.fetch(:allowfullscreen,
                                                "allowFullScreen")
          }
        end

        def video_url
          [
            "https://player.vimeo.com/video/#{vimeo_video_id}",
            video_url_params
          ].join("?")
        end

        def video_url_params
          {
            autoplay: vimeo_params.fetch(:autoplay, 0),
            loop: vimeo_params.fetch(:loop, 0),
            width: video_width,
            height: video_height
          }.compact.reject { |_, v| v.blank? }.to_query
        end

        def video_width
          vimeo_params.fetch(:width, 640)
        end

        def video_height
          vimeo_params.fetch(:height, 360)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("vimeo", Archangel::Liquid::Tags::VimeoTag)
