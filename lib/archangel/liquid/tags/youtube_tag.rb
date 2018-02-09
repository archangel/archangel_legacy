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
      #   {% youtube "-X2atEH7nCg" width:800 height:600 %}
      #   {% youtube "-X2atEH7nCg" id:"my_video" class:"my-video" %}
      #   {% youtube "-X2atEH7nCg" autoplay:1 %}
      #   {% youtube "-X2atEH7nCg" captions: %}
      #   {% youtube "-X2atEH7nCg" loop:1 %}
      #   {% youtube "-X2atEH7nCg" annotations:1 %}
      #   {% youtube "-X2atEH7nCg" start:10 %}
      #   {% youtube "-X2atEH7nCg" end:60 %}
      #   {% youtube "-X2atEH7nCg" showinfo:0 %}
      #   {% youtube "-X2atEH7nCg" allowfullscreen: %}
      #   {% youtube "-X2atEH7nCg" allowtransparency:0 %}
      #   {% youtube "-X2atEH7nCg" frameborder:4 %}
      #
      class YoutubeTag < ApplicationTag
        ##
        # {% youtube 'key' attributes %}
        #
        SYNTAX = /
          (?<key>#{::Liquid::QuotedFragment}+)
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # {% youtube 'key' attributes %}
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
            raise SyntaxError, Archangel.t("errors.syntax.youtube")
          end

          @key = ::Liquid::Variable.new(match[:key], options).name
          @attributes = {}

          match[:attributes].scan(SYNTAX_ATTRIBUTES) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the YouTube video
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered video
        #
        def render(_context)
          return if key.blank?

          content_tag(:iframe, "", video_attributes)
        end

        protected

        attr_reader :attributes, :key

        def video_attributes
          {
            id: attributes.fetch(:id, nil),
            class: attributes.fetch(:class, nil),
            style: attributes.fetch(:style, nil),
            src: video_url,
            width: video_width,
            height: video_height,
            frameborder: attributes.fetch(:frameborder, 0),
            allowtransparency: attributes.fetch(:allowtransparency, "true"),
            allowFullScreen:
              attributes.fetch(:allowfullscreen, "allowFullScreen")
          }
        end

        def video_url
          [
            "https://www.youtube.com/embed/#{key}",
            video_url_params
          ].join("?")
        end

        def video_url_params
          {
            ecver: 1,
            autohide: 2,
            color: attributes.fetch(:color, "red"),
            autoplay: attributes.fetch(:autoplay, 0),
            cc_load_policy: attributes.fetch(:captions, 0),
            iv_load_policy: attributes.fetch(:annotations, 0),
            loop: attributes.fetch(:loop, 0),
            showinfo: attributes.fetch(:showinfo, 1),
            start: attributes.fetch(:start, nil),
            end: attributes.fetch(:end, nil),
            width: video_width,
            height: video_height
          }.compact.reject { |_, value| value.blank? }.to_query
        end

        def video_width
          attributes.fetch(:width, 640)
        end

        def video_height
          attributes.fetch(:height, 360)
        end
      end
    end
  end
end

::Liquid::Template.register_tag("youtube", Archangel::Liquid::Tags::YoutubeTag)
