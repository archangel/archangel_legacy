# frozen_string_literal: true

module Archangel
  ##
  # Backend base controller
  #
  class BackendController < ApplicationController
    include Pundit

    include Archangel::AuthenticatableConcern
    include Archangel::AuthorizableConcern

    rescue_from Pundit::NotAuthorizedError, with: :render_401_error

    protected

    def layout_from_theme
      "backend"
    end
  end
end
