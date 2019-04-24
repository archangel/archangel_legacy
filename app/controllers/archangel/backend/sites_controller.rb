# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend sites controller
    #
    class SitesController < BackendController
      ##
      # Backend site
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/site
      #   GET /backend/site.json
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
      #     }
      #   }
      #
      def show
        site = resource_content

        respond_with site
      end

      ##
      # Edit backend site
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/site/edit
      #   GET /backend/site/edit.json
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
      #     }
      #   }
      #
      def edit
        site = resource_content

        respond_with site
      end

      ##
      # Update backend site
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   PATCH /backend/site
      #   PATCH /backend/site.json
      #   PUT   /backend/site
      #   PUT   /backend/site.json
      #
      # Response
      #   {
      #     "site": {
      #       "name": "Site Name",
      #       "theme": "my_theme",
      #       "locale": "en",
      #       "logo": {
      #        "url": "/uploads/file.png",
      #         "large": {
      #           "url": "/uploads/large_file.png"
      #         },
      #         "medium": {
      #           "url": "/uploads/medium_file.png"
      #         },
      #         "small": {
      #           "url": "/uploads/small_file.png"
      #         },
      #         "tiny": {
      #           "url": "/uploads/tiny_file.png"
      #         }
      #       }
      #     }
      #   }
      #
      def update
        site = resource_content

        site.update(resource_params)

        respond_with site, location: -> { location_after_update }
      end

      protected

      def permitted_attributes
        [
          :locale, :logo, :name, :remove_logo, :theme,
          :allow_registration,
          metatags_attributes: %i[id _destroy name content]
        ]
      end

      def resource_content
        @site = current_site

        authorize @site
      end

      def resource_params
        params.require(resource_scope).permit(permitted_attributes)
      end

      def resource_scope
        controller_name.singularize.to_sym
      end

      def location_after_update
        location_after_save
      end

      def location_after_save
        backend_site_path
      end
    end
  end
end
