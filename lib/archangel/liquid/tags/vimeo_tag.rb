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
      #   {% vimeo "183344978" width:800 height:60 %}
      #   {% vimeo "183344978" id:"my_video" class:"my-video" %}
      #   {% vimeo "183344978" autoplay:1 %}
      #   {% vimeo "183344978" loop:1 %}
      #   {% vimeo "183344978" allowfullscreen:0 %}
      #   {% vimeo "183344978" allowtransparency:0 %}
      #   {% vimeo "183344978" frameborder:4 %}
      #
      class VimeoTag < ApplicationTag
        ##
        # Vimeo video embed for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = SLUG_ATTRIBUTES_SYNTAX.match(markup)

          return if match.blank?

          @key = ::Liquid::Variable.new(match[:slug], options).name
          @attributes = {}

          match[:attributes].scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the Vimeo video
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered video
        #
        def render(_context)
          if key.blank?
            return content_tag(:span, Archangel.t("errors.syntax.vimeo"),
                               class: "liquid-syntax-error")
          end

          content_tag(:iframe, "", video_attributes)
        end

        protected

        attr_reader :attributes, :key

        def video_attributes
          {
            src: video_url,
            width: video_width,
            height: video_height
          }.merge(video_fetch_attributes)
        end

        def video_fetch_attributes
          {
            id: nil,
            class: nil,
            style: nil,
            frameborder: 0,
            allowtransparency: "true",
            allowFullScreen: "allowFullScreen"
          }.each_with_object({}) do |(key, value), hash|
            hash[key] = attributes.fetch(key.to_s.downcase.to_sym, value)
          end
        end

        def video_url
          [
            "https://player.vimeo.com/video/#{key}",
            video_url_params
          ].join("?")
        end

        def video_url_params
          {
            autoplay: attributes.fetch(:autoplay, 0),
            loop: attributes.fetch(:loop, 0),
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

::Liquid::Template.register_tag("vimeo", Archangel::Liquid::Tags::VimeoTag)
