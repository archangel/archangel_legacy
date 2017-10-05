# frozen_string_literal: true

module Archangel
  class BackendController < ApplicationController
    include Pundit

    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :render_401
  end
end
