# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  ##
  # Application base controller
  #
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Archangel::Controllers::PaginatableConcern
    include Archangel::Controllers::ThemableConcern

    before_action :set_locale

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    helper Archangel::FlashHelper

    theme :theme_resolver

    rescue_from AbstractController::ActionNotFound,
                ActiveRecord::RecordNotFound,
                ActionView::MissingTemplate, with: :render_404_error

    ##
    # Current site
    #
    # Response
    #   {
    #     "id": 123,
    #     "name": "Site Name",
    #     "theme": "my_theme",
    #     "locale": "en",
    #     "logo": {
    #       "url": "/uploads/file.png",
    #       "large": {
    #         "url": "/uploads/large_file.png"
    #       },
    #       "medium": {
    #         "url": "/uploads/medium_file.png"
    #       },
    #       "small": {
    #         "url": "/uploads/small_file.png"
    #       },
    #       "tiny": {
    #         "url": "/uploads/tiny_file.png"
    #       }
    #     },
    #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
    #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
    #   }
    #
    def current_site
      @current_site ||= Archangel::Site.current
    end

    ##
    # Error 401
    #
    # Render a 401 (unauthorized) error response
    #
    # Response
    #   {
    #     "status": 401,
    #     "error": "Access is denied due to invalid credentials"
    #   }
    #
    # @param exception [Object] error object
    # @return [String] response
    #
    def render_401_error(exception = nil)
      render_error("archangel/errors/error_401", :unauthorized, exception)
    end

    ##
    # Error 404
    #
    # Render a 404 (not found) error response
    #
    # Response
    #   {
    #     "status": 404,
    #     "error": "Page not found"
    #   }
    #
    # @param exception [Object] error object
    # @return [String] response
    #
    def render_404_error(exception = nil)
      render_error("archangel/errors/error_404", :not_found, exception)
    end

    ##
    # Error renderer
    #
    # Formats
    #   HTML, JSON
    #
    # Response
    #   {
    #     "status": XYZ,
    #     "error": "Error message"
    #   }
    #
    # @param path [String] error template path
    # @param status [String,Symbol] response status code
    # @param _exception [Object] error object
    # @return [String] response
    #
    def render_error(path, status, _exception = nil)
      respond_to do |format|
        format.html { render(template: path, status: status) }
        format.json { render(template: path, status: status, layout: false) }
      end
    end

    protected

    ##
    # Redirect location after sign in
    #
    # Archangel currently only allows `admin` and `editor` roles access to sign
    # in/out. There is no other functionality available to other user groups.
    # Redirect to the backend. If an extension is applied to add more user
    # groups, it will need to overwrite this method in order to redirect to the
    # preferred location depending on the role.
    #
    # @param resource_or_scope [String,Symbol] resource or scope signing in
    # @return [String] redirect to after sign in
    #
    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || backend_root_path
    end

    ##
    # Redirect location after sign out
    #
    # @param _resource_or_scope [String,Symbol] resource or scope signing out
    # @return [String] redirect to after sign out
    #
    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end

    ##
    # Theme switcher
    #
    # Theme to use to retrieve Javascripts and styles from. Auth and Backend
    # will always use the "default" theme. Frontend will override this to return
    # selected theme for Site.
    #
    # @return [String] default
    #
    def theme_resolver
      "default"
    end

    ##
    # Theme layout
    #
    # @return [String] backend
    #
    def layout_from_theme
      "backend"
    end

    def set_locale
      locale = session[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
    end

    private

    def locale_for(locale)
      I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end
  end
end
