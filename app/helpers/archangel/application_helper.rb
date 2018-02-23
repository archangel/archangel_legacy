# frozen_string_literal: true

module Archangel
  ##
  # Application helpers
  #
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    ##
    # Site locale. Default `en`
    #
    # Example
    #   <%= locale %> #=> "en"
    #
    # @return [String] site locale
    #
    def locale
      current_site.locale || Archangel::LANGUAGE_DEFAULT
    end

    ##
    # Language direction ("ltr" or "rtl"). Default `ltr`
    #
    # Example
    #   <%= text_direction %> #=> "ltr"
    #
    # @return [String] language direction
    #
    def text_direction
      Archangel.t("language.#{locale}.direction", default: "ltr")
    end
  end
end
