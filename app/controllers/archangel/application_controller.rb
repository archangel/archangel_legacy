# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :set_locale

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site
    helper_method :page_num
    helper_method :per_page

    def current_site
      @current_site ||= Archangel::Site.current
    end

    def per_page
      params.fetch(:per, per_page_default)
    end

    def page_num
      params.fetch(Kaminari.config.param_name, 1)
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
