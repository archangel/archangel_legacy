# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend pages controller
    #
    class PagesController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend pages
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/pages
      #   GET /backend/pages.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "parent_id": nil,
      #       "template_id": nil,
      #       "title": "Page Title",
      #       "slug": "my-page",
      #       "path": "my-page",
      #       "content": "</p>Content of the Page</p>",
      #       "homepage": false,
      #       "meta_keywords": "keywords,for,the,page",
      #       "meta_description": "Description of the page",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @pages
      end

      ##
      # Backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the page id
      #
      # Request
      #   GET /backend/pages/:id
      #   GET /backend/pages/:id.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "parent_id": nil,
      #     "template_id": nil,
      #     "title": "Page Title",
      #     "slug": "my-page",
      #     "path": "my-page",
      #     "content": "</p>Content of the Page</p>",
      #     "homepage": false,
      #     "meta_keywords": "keywords,for,the,page",
      #     "meta_description": "Description of the page",
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @page
      end

      ##
      # New backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/pages/new
      #   GET /backend/pages/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": 123,
      #     "parent_id": nil,
      #     "template_id": nil,
      #     "title": null,
      #     "slug": null,
      #     "path": null,
      #     "content": null,
      #     "homepage": false,
      #     "meta_keywords": null,
      #     "meta_description": null,
      #     "published_at": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @page
      end

      ##
      # Create backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/pages
      #   POST /backend/pages.json
      #
      # Paramaters
      #   {
      #     "page": {
      #       "parent_id": nil,
      #       "template_id": nil,
      #       "title": "Page Title",
      #       "slug": "my-page",
      #       "content": "</p>Content of the Page</p>",
      #       "homepage": false,
      #       "meta_keywords": "keywords,for,the,page",
      #       "meta_description": "Description of the page",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def create
        @page.save

        respond_with @page, location: -> { location_after_create }
      end

      ##
      # Edit backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the page id
      #
      # Request
      #   GET /backend/pages/:id/edit
      #   GET /backend/pages/:id/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "parent_id": nil,
      #     "template_id": nil,
      #     "title": "Page Title",
      #     "slug": "my-page",
      #     "path": "my-page",
      #     "content": "</p>Content of the Page</p>",
      #     "homepage": false,
      #     "meta_keywords": "keywords,for,the,page",
      #     "meta_description": "Description of the page",
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @page
      end

      ##
      # Update backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the page id
      #
      # Request
      #   PATCH /backend/pages/:id
      #   PATCH /backend/pages/:id.json
      #   PUT   /backend/pages/:id
      #   PUT   /backend/pages/:id.json
      #
      # Paramaters
      #   {
      #     "page": {
      #       "parent_id": nil,
      #       "template_id": nil,
      #       "title": "Page Title",
      #       "slug": "my-page",
      #       "content": "</p>Content of the Page</p>",
      #       "homepage": false,
      #       "meta_keywords": "keywords,for,the,page",
      #       "meta_description": "Description of the page",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def update
        @page.update(resource_params)

        respond_with @page, location: -> { location_after_update }
      end

      ##
      # Destroy backend page
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the page id
      #
      # Request
      #   DELETE /backend/pages/:id
      #   DELETE /backend/pages/:id.json
      #
      def destroy
        @page.destroy

        respond_with @page, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content homepage meta_description meta_keywords parent_id path
           published_at slug template_id title]
      end

      def set_resources
        @pages = current_site.pages
                             .order(title: :asc)
                             .page(page_num).per(per_page)

        authorize @pages
      end

      def set_resource
        resource_id = params.fetch(:id)

        @page = current_site.pages.find_by!(id: resource_id)

        authorize @page
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @page = current_site.pages.new(new_params)

        authorize @page
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        controller_name.singularize.to_sym
      end

      def location_after_create
        location_after_save
      end

      def location_after_update
        location_after_save
      end

      def location_after_destroy
        location_after_save
      end

      def location_after_save
        backend_pages_path
      end
    end
  end
end
