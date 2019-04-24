# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Controller meta tag concern
    #
    module MetatagableConcern
      extend ActiveSupport::Concern

      included do
        before_action :apply_default_meta_tags, if: -> { request.get? },
                                                unless: -> { request.xhr? }
      end

      ##
      # Set meta tags
      #
      # @param meta_tags [Hash] list of meta tags
      #
      def assign_meta_tags(meta_tags = {})
        meta = meta_tags.reject { |_name, value| value.blank? }

        set_meta_tags(meta)
      end

      protected

      def apply_default_meta_tags
        assign_meta_tags(default_meta_tags)
      end

      def default_meta_tags
        {
          reverse: true,
          site: current_site.name,
          canonical: request.url
        }
      end
    end
  end
end
