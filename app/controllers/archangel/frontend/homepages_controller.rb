# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::FrontendController
  #
  module Frontend
    ##
    # Frontend homepages controller
    #
    # Extends Archangel::Frontend/PagesController to provide functionality
    #
    class HomepagesController < PagesController
      protected

      ##
      # Find and assign resource to the view
      #
      def set_resource
        @page = current_site.pages.published.homepage.first!
      end

      ##
      # Override. Do not redirect. This is the homepage.
      #
      # @return [Boolean] false
      #
      def redirect_to_homepage?
        false
      end
    end
  end
end
