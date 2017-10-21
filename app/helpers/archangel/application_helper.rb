# frozen_string_literal: true

module Archangel
  module ApplicationHelper
    def locale
      Archangel::Site.current.locale || Archangel::LANGUAGE_DEFAULT
    end

    def text_direction
      Archangel::RTL_LANGUAGES.include?(locale) ? "rtl" : "ltr"
    end
  end
end
