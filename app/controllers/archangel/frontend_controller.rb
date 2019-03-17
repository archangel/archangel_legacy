# frozen_string_literal: true

module Archangel
  ##
  # Frontend base controller
  #
  class FrontendController < ApplicationController
    include Archangel::SeoableConcern

    protected

    ##
    # Theme switcher
    #
    # Theme to use to retrieve Javascripts and styles from.
    #
    # @return [String] the theme
    #
    def theme_resolver
      theme = current_site.theme

      Archangel::THEMES.include?(theme) ? theme : Archangel::THEME_DEFAULT
    end
  end
end
