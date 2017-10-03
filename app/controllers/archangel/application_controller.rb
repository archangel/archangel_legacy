# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    respond_to :html, :json
    responders :flash, :http_cache
  end
end
