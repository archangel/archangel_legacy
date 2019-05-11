# frozen_string_literal: true

module Archangel
  ##
  # Backend base controller
  #
  class BackendController < ApplicationController
    include Pundit

    include Archangel::Controllers::AuthenticatableConcern
    include Archangel::Controllers::AuthorizableConcern
    include Archangel::Controllers::MetatagableConcern
    include Archangel::Helpers::ActionableConcern

    rescue_from Pundit::NotAuthorizedError, with: :render_401_error

    protected

    def layout_from_theme
      "backend"
    end

    def default_meta_tags
      super.merge(noindex: true, nofollow: true, noarchive: true)
    end
  end
end
