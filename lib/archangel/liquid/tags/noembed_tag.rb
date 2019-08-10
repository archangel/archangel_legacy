# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Noembed custom tag for Liquid
      #
      # For more information about Noembed, see https://noembed.com/
      #
      # Example
      #   {% noembed "https://www.youtube.com/watch?v=NOGEyBeoBGM" %}
      #   {% noembed "https://vimeo.com/70707344" %}
      #   {% noembed "https://vimeo.com/70707344" remote: true %}
      #   {% noembed "https://vimeo.com/70707344" maxwidth:600 %}
      #   {% noembed "https://vimeo.com/70707344" maxheight:400 %}
      #
      class NoembedTag < ApplicationTag
        require "digest/md5"
        require "net/http"

        ##
        # Noembed for Liquid
        #
        # @param tag_name [String] the Liquid tag name
        # @param markup [String] the passed options
        # @param options [Object] options
        #
        def initialize(tag_name, markup, options)
          super

          match = URL_ATTRIBUTES_SYNTAX.match(markup)

          if match.blank?
            raise ::Liquid::SyntaxError, Archangel.t("errors.syntax.noembed")
          end

          @url = ::Liquid::Variable.new(match[:url], options).name
          @attributes = { remote: false }

          match[:attributes].scan(KEY_VALUE_ATTRIBUTES_SYNTAX) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        ##
        # Render the Widget
        #
        # @param _context [Object] the Liquid context
        # @return [String] the rendered Widget
        #
        def render(_context)
          return if url.blank?

          noembed_id = "noembed-#{Digest::MD5.hexdigest(url)}"

          content = if %w[1 true yes y].include?(attributes[:remote].to_s)
                      build_js_request(noembed_id)
                    else
                      build_ruby_request
                    end

          content_tag(:div, raw(content), id: noembed_id, class: "noembed")
        end

        protected

        attr_reader :attributes, :url

        def build_ruby_request
          uri = URI(noembed_url)
          uri.query = URI.encode_www_form(query_params)

          res = Net::HTTP.get_response(uri)

          unless res.is_a?(Net::HTTPSuccess)
            return "<span class='status error'>Error connecting to noembed " \
                   "server.</span>"
          end

          resp = JSON.parse(res.body)

          if resp.fetch("html", nil).blank?
            message = resp["error"] || "Unknown error."
            "<span class='status error'>#{message}</span>"
          else
            resp["html"]
          end
        end

        def build_js_request(noembed_id)
          noembed_request_url = [
            noembed_url,
            query_params.to_query
          ].join("?")

          <<-NOEMBED
  <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
      var noembedElement = document.querySelector('##{noembed_id}'),
          noembedRequest = new XMLHttpRequest();
      noembedElement.innerHTML = '<span class="status">Embedding&hellip;</span>';
      noembedRequest.open('GET', '#{noembed_request_url}', true);
      noembedRequest.setRequestHeader('Content-type', 'application/json');
      noembedRequest.onload = function() {
        var response = JSON.parse(noembedRequest.responseText)
        if (response.html) {
          noembedElement.innerHTML = response.html;
        }
        else {
          noembedElement.innerHTML = '<span class="status error">' + (response.error || 'Unknown error.') + '</span>';
        }
      };
      noembedRequest.onerror = function () {
        noembedElement.innerHTML = '<span class="status error">Error connecting to noembed server.</span>';
      };
      noembedRequest.send(null);
    });
  </script>
          NOEMBED
        end

        def noembed_url
          "https://noembed.com/embed"
        end

        def query_params
          {
            url: url,
            maxwidth: attributes.fetch(:maxwidth, nil),
            maxheight: attributes.fetch(:maxheight, nil),
            nowrap: attributes.fetch(:nowrap, "on")
          }.compact.reject { |_, val| val.blank? }
        end
      end
    end
  end
end

::Liquid::Template.register_tag("noembed", Archangel::Liquid::Tags::NoembedTag)
