# frozen_string_literal: true

module Archangel
  ##
  # Controller SEO concern
  #
  module SeoableConcern
    extend ActiveSupport::Concern

    included do
      before_action :apply_default_meta_tags, if: -> { request.get? },
                                              unless: -> { request.xhr? }
    end

    # Set meta tags
    #
    # @param meta_tags [Hash] list of meta tags
    def apply_meta_tags(meta_tags = {})
      meta = meta_tags.reject { |_name, value| value.blank? }

      set_meta_tags(meta)
    end

    protected

    def apply_default_meta_tags
      apply_meta_tags(default_meta_tags)
    end

    def default_meta_tags
      {
        reverse:     true,
        site:        current_site.name,
        canonical:   request.url,
        image_src:   current_site.logo.url,
        description: current_site.meta_description,
        keywords:    current_site.meta_keywords.to_s.split(",")
      }
    end
  end
end
