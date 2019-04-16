# frozen_string_literal: true

module Archangel
  ##
  # Authentication base controller
  #
  class AuthController < ApplicationController
    include Archangel::Controllers::MetatagableConcern

    before_action :configure_permitted_parameters

    protected

    def layout_from_theme
      "auth"
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username])
    end

    def default_meta_tags
      super.merge(noindex: true, nofollow: true, noarchive: true)
    end
  end
end
