# frozen_string_literal: true

module Archangel
  ##
  # Application helpers
  #
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    ##
    # Frontend resource path.
    #
    # Same as `frontend_page_path` except it prints out nested resources in a
    # nice way.
    #
    # Example
    #   <%= frontend_resource_path('foo/bar') %> #=> /foo/bar
    #   <%= frontend_resource_path(@page) %> #=> /foo/bar
    #
    # @return [String] frontend resource path
    #
    def frontend_resource_path(resource)
      permalink_path = proc do |path|
        archangel.frontend_page_path(path).gsub("%2F", "/")
      end

      return permalink_path.call(resource) unless resource.class == Page
      return archangel.frontend_root_path if resource.homepage?

      permalink_path.call(resource.path)
    end

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
