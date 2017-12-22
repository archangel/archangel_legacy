# frozen_string_literal: true

module Archangel
  ##
  # Glyphicon helpers
  #
  module GlyphiconHelper
    ##
    # Converts Rails flash message type to Bootstrap flash message type
    #
    # @param name [String] the Glyphicon icon name
    # @param original_options [Hash] icon options
    # @return [String] the generated HTML for Glyphicon icon
    #
    def glyphicon_icon(name = "flag", original_options = {})
      options = original_options.deep_dup
      classes = [
        "glyphicon",
        "glyphicon-#{name}",
        options.delete(:class)
      ].reject(&:blank?).flatten
      text = options.delete(:text)
      icon = content_tag(:span, nil, options.merge(class: classes,
                                                   aria: { hidden: true }))
      Private.icon_join(icon, text)
    end

    ##
    # Glyphicon icon joiner
    #
    module Private
      extend ActionView::Helpers::OutputSafetyHelper

      ##
      # Join Glyphicon paramaters to join
      #
      # @param icon [String] the Glyphicon icon name
      # @param text [String] the Glyphicon text
      # @return [String] the Glyphicon with text
      #
      def self.icon_join(icon, text)
        return icon if text.blank?

        elements = [icon, ERB::Util.html_escape(text)]

        safe_join(elements, " ")
      end
    end
  end
end
