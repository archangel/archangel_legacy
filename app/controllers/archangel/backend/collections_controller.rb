# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend collections controller
    #
    class CollectionsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend collections
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/collections
      #   GET /backend/collections.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "name": "Collection Name",
      #       "slug": "collection_slug",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @collections
      end

      ##
      # Backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   GET /backend/collections/:slug
      #   GET /backend/collections/:slug.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "Collection Name",
      #     "slug": "collection_slug",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @collection
      end

      ##
      # New backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/collections/new
      #   GET /backend/collections/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": 123,
      #     "name": null,
      #     "slug": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @collection
      end

      ##
      # Create backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/collections
      #   POST /backend/collections.json
      #
      # Paramaters
      #   {
      #     "collection": {
      #       "name": "Collection Name",
      #       "slug": "collection_slug"
      #     }
      #   }
      #
      def create
        @collection.save

        respond_with @collection, location: -> { location_after_create }
      end

      ##
      # Edit backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   GET /backend/collections/:slug/edit
      #   GET /backend/collections/:slug/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "Collection Name",
      #     "slug": "collection_slug",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @collection
      end

      ##
      # Update backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   PATCH /backend/collections/:slug
      #   PATCH /backend/collections/:slug.json
      #   PUT   /backend/collections/:slug
      #   PUT   /backend/collections/:slug.json
      #
      # Response
      #   {
      #     "collection": {
      #       "name": "Collection Name",
      #       "slug": "collection_slug"
      #     }
      #   }
      #
      def update
        @collection.update(resource_params)

        respond_with @collection, location: -> { location_after_update }
      end

      ##
      # Destroy backend collection
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   DELETE /backend/collections/:slug
      #   DELETE /backend/collections/:slug.json
      #
      def destroy
        @collection.destroy

        respond_with @collection, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        [
          :name, :slug,
          fields_attributes: %i[id _destroy classification label required slug]
        ]
      end

      def set_resources
        @collections = current_site.collections
                                   .order(name: :asc)
                                   .page(page_num).per(per_page)

        authorize @collections
      end

      def set_resource
        resource_id = params.fetch(:id)

        @collection = current_site.collections.find_by!(slug: resource_id)

        authorize @collection
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @collection = current_site.collections.new(new_params)

        @collection.fields.build unless @collection.fields.present?

        authorize @collection
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
        backend_collections_path
      end
    end
  end
end
