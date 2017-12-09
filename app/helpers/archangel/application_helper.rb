# frozen_string_literal: true

module Archangel
  module ApplicationHelper
    def locale
      Archangel::Site.current.locale || Archangel::LANGUAGE_DEFAULT
    end

    def text_direction
      Archangel.t("language.#{locale}.direction", default: "ltr")
    end
  end
end
