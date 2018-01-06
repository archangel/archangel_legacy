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
      before_action :set_resource

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
      #     },
      #     "content": "</p>Content of the Widget</p>",
      #     "template_id": 123,
      #     "meta_keywords": "keywords,for,the,site",
      #     "meta_description": "Description of the site",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @site
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
      #     },
      #     "content": "</p>Content of the Widget</p>",
      #     "template_id": 123,
      #     "meta_keywords": "keywords,for,the,site",
      #     "meta_description": "Description of the site"
      #   }
      #
      def edit
        respond_with @site
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
      #       },
      #       "content": "</p>Content of the Widget</p>",
      #       "template_id": 123,
      #       "meta_keywords": "keywords,for,the,site",
      #       "meta_description": "Description of the site"
      #     }
      #   }
      #
      def update
        @site.update(resource_params)

        respond_with @site, location: -> { location_after_update }
      end

      protected

      def permitted_attributes
        %w[favicon locale logo meta_description meta_keywords name
           remove_favicon remove_logo theme]
      end

      def set_resource
        @site = current_site

        authorize @site
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
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
