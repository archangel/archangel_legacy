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
        %w[
          author copyright description keywords robots googlebot viewport
          google-site-verification
          og:title og:image og:description
          twitter:card twitter:description twitter:image twitter:title
        ]
      end

      ##
      # Suggested metatags
      #
      # @return [Array] suggested metatags
      #
      def suggested_metatags
        %w[
          description keywords robots googlebot
          og:title og:image og:description
          twitter:card twitter:description twitter:image twitter:title
        ]
      end
    end
  end
end
