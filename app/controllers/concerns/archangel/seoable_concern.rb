# frozen_string_literal: true

module Archangel
  module SeoableConcern
    extend ActiveSupport::Concern

    included do
      before_action :apply_default_meta_tags, if: -> { request.get? },
                                              unless: -> { request.xhr? }
    end

    def apply_meta_tags(options = {})
      set_meta_tags(options.reject { |_k, val| val.blank? })
    end

    protected

    def apply_default_meta_tags
      apply_meta_tags reverse:     true,
                      site:        current_site.name,
                      canonical:   request.url,
                      image_src:   current_site.logo.url,
                      description: current_site.meta_description,
                      keywords:    current_site.meta_keywords.to_s.split(","),
                      icon:        current_site.favicon.url
    end
  end
end
