# frozen_string_literal: true

module Archangel
  module Frontend
    module PagesHelper
      def locale
        current_site.locale || Archangel::LANGUAGE_DEFAULT
      end

      def text_direction
        Archangel::RTL_LANGUAGES.include?(locale) ? "rtl" : "ltr"
      end
    end
  end
end
