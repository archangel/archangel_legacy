# frozen_string_literal: true

module Archangel
  ##
  # Backend helpers
  #
  module Backend
    ##
    # Metatags helpers
    #
    module MetatagsHelper
      ##
      # Suggested site metatags
      #
      # @return [Array] suggested site metatags
      #
      def suggested_site_metatags
        %w[description keywords author copyright viewport
           google-site-verification] +
          suggested_bot_metatags +
          suggested_og_metatags +
          suggested_twitter_metatags
      end

      ##
      # Suggested metatags
      #
      # @return [Array] suggested metatags
      #
      def suggested_metatags
        %w[description keywords] +
          suggested_bot_metatags +
          suggested_og_metatags +
          suggested_twitter_metatags
      end

      protected

      def suggested_bot_metatags
        %w[googlebot robots]
      end

      def suggested_og_metatags
        %w[og:title og:image og:description]
      end

      def suggested_twitter_metatags
        %w[twitter:card twitter:description twitter:image twitter:title]
      end
    end
  end
end
