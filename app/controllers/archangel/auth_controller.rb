# frozen_string_literal: true

module Archangel
  class AuthController < ApplicationController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name username])
    end

    def load_site_layout
      "archangel/layouts/auth"
    end
  end
end
