# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Archangel::ActionableConcern
    include Archangel::PaginatableConcern

    before_action :set_locale

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    helper Archangel::FlashHelper
    helper Archangel::GlyphiconHelper

    rescue_from ActionController::UnknownController,
                AbstractController::ActionNotFound,
                ActionView::MissingTemplate,
                ActiveRecord::RecordNotFound, with: :render_404

    def current_site
      @current_site ||= Archangel::Site.current
    end

    def render_401(exception = nil)
      render_error("archangel/errors/error_401", :unauthorized, exception)
    end

    def render_404(exception = nil)
      render_error("archangel/errors/error_404", :not_found, exception)
    end

    def render_error(path, status, _exception)
      respond_to do |format|
        format.html { render(template: path, status: status) }
        format.json { render(template: path, status: status) }
      end
    end

    protected

    def set_locale
      locale = session[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
    end

    def locale_for(locale)
      I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end

    def per_page_default
      Kaminari.config.default_per_page
    end
  end
end
