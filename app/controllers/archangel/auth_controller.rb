# frozen_string_literal: true

module Archangel
  ##
  # Authentication base controller
  #
  class AuthController < ApplicationController
    include Archangel::Controllers::MetatagableConcern

    protected

    ##
    # Theme layout
    #
    # @return [String] auth
    #
    def layout_from_theme
      "auth"
    end

    def default_meta_tags
      super.merge(noindex: true, nofollow: true, noarchive: true)
    end
  end
end
