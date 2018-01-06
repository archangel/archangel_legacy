# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  ##
  # Application base controller
  #
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Archangel::ActionableConcern
    include Archangel::PaginatableConcern
    include Archangel::ThemableConcern

    before_action :set_locale

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    helper Archangel::FlashHelper
    helper Archangel::GlyphiconHelper

    theme :theme_resolver

    rescue_from ActionController::UnknownController,
                AbstractController::ActionNotFound,
                ActionView::MissingTemplate,
                ActiveRecord::RecordNotFound, with: :render_404_error

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
    #     "content": "</p>Content of the Widget</p>",
    #     "template_id": 123,
    #     "meta_keywords": "keywords,for,the,site",
    #     "meta_description": "Description of the site",
    #     "deleted_at": null,
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
    # Response
    #   {
    #     "status": 401,
    #     "error": "Access is denied due to invalid credentials"
    #   }
    #
    def render_401_error(exception = nil)
      render_error("archangel/errors/error_401", :unauthorized, exception)
    end

    ##
    # Error 404
    #
    # Response
    #   {
    #     "status": 404,
    #     "error": "Page not found"
    #   }
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
    def render_error(path, status, _exception)
      respond_to do |format|
        format.html { render(template: path, status: status) }
        format.json { render(template: path, status: status, layout: false) }
      end
    end

    protected

    ##
    # Redirect location after sign out
    #
    # Archangel currently only allows `admin` and `editor` roles access to sign
    # in/out. There is no other functionality available to other user groups. If
    # an extension is applied to add more user groups, it will need to overwrite
    # this method in order to redirect to the preferred location for the role.
    #
    # @param _resource_or_scope [String,Symbol] resource or scope signing out
    # @return [String] redirect to after sign out
    #
    def after_sign_out_path_for(_resource_or_scope)
      backend_root_path
    end

    def theme_resolver
      theme = current_site.theme

      Archangel::THEMES.include?(theme) ? theme : Archangel::THEME_DEFAULT
    end

    def layout_from_theme
      "frontend"
    end

    def set_locale
      locale = session[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
    end

    def locale_for(locale)
      I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end
  end
end
