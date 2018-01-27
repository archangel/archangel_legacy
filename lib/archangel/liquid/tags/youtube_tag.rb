# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # YouTube custom tag for Liquid
      #
      # Example
      #   Given the YouTube URL https://www.youtube.com/watch?v=-X2atEH7nCg
      #   {% youtube "-X2atEH7nCg" %}
      #   {% youtube "-X2atEH7nCg" width="800" height="600" %}
      #   {% youtube "-X2atEH7nCg" id="my_video" class="my-video" %}
      #   {% youtube "-X2atEH7nCg" autoplay="1" %}
      #   {% youtube "-X2atEH7nCg" captions="1" %}
      #   {% youtube "-X2atEH7nCg" loop="1" %}
      #   {% youtube "-X2atEH7nCg" annotations="1" %}
      #   {% youtube "-X2atEH7nCg" start="10" %}
      #   {% youtube "-X2atEH7nCg" end="60" %}
      #   {% youtube "-X2atEH7nCg" showinfo="0" %}
      #   {% youtube "-X2atEH7nCg" allowfullscreen="0" %}
      #   {% youtube "-X2atEH7nCg" allowtransparency="0" %}
      #   {% youtube "-X2atEH7nCg" frameborder="4" %}
      #
      class YoutubeTag < BaseTag
        attr_reader :youtube_video_id, :youtube_params

        def initialize(tag_name, params, tokens)
          super

          @youtube_video_id, @youtube_params = key_with_params(params)
        end

        ##
        # Render the Widget
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered Widget
        #
        def render(_context)
          return if youtube_video_id.blank?

          content_tag(:iframe, "", video_attributes)
        end

        protected

        def video_attributes
          {
            id: youtube_params.fetch(:id, nil),
            class: youtube_params.fetch(:class, nil),
            style: youtube_params.fetch(:style, nil),
            src: video_url,
            width: video_width,
            height: video_height,
            frameborder: youtube_params.fetch(:frameborder, 0),
            allowtransparency: youtube_params.fetch(:allowtransparency, "true"),
            allowFullScreen:
              youtube_params.fetch(:allowfullscreen, "allowFullScreen")
          }
        end

        def video_url
          [
            "https://www.youtube.com/embed/#{youtube_video_id}",
            video_url_params
          ].join("?")
        end

        def video_url_params
          {
            ecver: 1,
            color: "red",
            autohide: 2,
            autoplay: youtube_params.fetch(:autoplay, 0),
            cc_load_policy: youtube_params.fetch(:captions, 0),
            iv_load_policy: youtube_params.fetch(:annotations, 0),
            loop: youtube_params.fetch(:loop, 0),
            showinfo: youtube_params.fetch(:showinfo, 1),
            start: youtube_params.fetch(:start, nil),
            end: youtube_params.fetch(:end, nil),
            width: video_width,
            height: video_height
          }.compact.reject { |_, v| v.blank? }.to_query
        end

        def video_width
          youtube_params.fetch(:width, 640)
        end

        def video_height
          youtube_params.fetch(:height, 360)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("youtube", Archangel::Liquid::Tags::YoutubeTag)
