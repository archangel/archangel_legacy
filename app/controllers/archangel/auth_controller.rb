# frozen_string_literal: true

module Archangel
  class AuthController < ApplicationController
    before_action :configure_permitted_parameters

    protected

    def layout_from_theme
      "auth"
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username])
    end
  end
end
