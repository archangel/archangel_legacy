# frozen_string_literal: true

module Archangel
  module GlyphiconHelper
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

    module Private
      extend ActionView::Helpers::OutputSafetyHelper

      def self.icon_join(icon, text)
        return icon if text.blank?

        elements = [icon, ERB::Util.html_escape(text)]

        safe_join(elements, " ")
      end
    end
  end
end
