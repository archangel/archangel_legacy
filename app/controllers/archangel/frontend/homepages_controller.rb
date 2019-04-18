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
      ##
      # Frontend page
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /
      #
      # Response
      #   {
      #     "id": 123,
      #     "title": "Homepage Title",
      #     "permalink": "/",
      #     "content": "</p>Content of the homepage</p>",
      #     "homepage": true,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #   }
      #
      def show
        respond_to do |format|
          format.html do
            render inline: liquid_rendered_template_content,
                   layout: layout_from_theme
          end
          format.json do
            @page.content = liquid_rendered_content

            render json: @page, layout: false
          end
        end
      end

      protected

      ##
      # Find and assign resource to the view
      #
      def set_resource
        @page = current_site.pages.published.homepage.first!
      end
    end
  end
end
