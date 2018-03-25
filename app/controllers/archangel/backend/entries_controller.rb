# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend collection entries controller
    #
    class EntriesController < BackendController
      before_action :set_parent_resource
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend collection entries
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/collections/:slug/entries/:id
      #   GET /backend/collections/:slug/entries/:id.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "collection_id": 123,
      #       "value": {
      #         "field_key_1": "Field 1 Value",
      #         "field_key_2": "Field 2 Value"
      #       },
      #       "position": 0,
      #       "available_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @entries
      end

      ##
      # Backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #   [Integer] id - the entry id
      #
      # Request
      #   GET /backend/collections/:slug/entries/:id
      #   GET /backend/collections/:slug/entries/:id.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "collection_id": 123,
      #     "value": {
      #       "field_key_1": "Field 1 Value",
      #       "field_key_2": "Field 2 Value"
      #     },
      #     "position": 0,
      #     "available_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @entry
      end

      ##
      # New backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/collections/:slug/entries/new
      #   GET /backend/collections/:slug/entries/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "collection_id": null,
      #     "value": null,
      #     "position": null,
      #     "available_at": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @entry
      end

      ##
      # Create backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   POST /backend/collections/:slug/entries
      #   POST /backend/collections/:slug/entries.json
      #
      # Paramaters
      #   {
      #     "collection_entry": {
      #       "value": {
      #         "field_key_1": "Field 1 Value",
      #         "field_key_2": "Field 2 Value"
      #       },
      #       "available_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def create
        @entry.save

        respond_with @entry, location: -> { location_after_create }
      end

      ##
      # Edit backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #   [Integer] id - the entry id
      #
      # Request
      #   GET /backend/collections/:slug/entries/:id/edit
      #   GET /backend/collections/:slug/entries/:id/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "Widget Name",
      #     slug": "widget_slug",
      #     "content": "</p>Content of the Widget</p>",
      #     "template_id": 123,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @entry
      end

      ##
      # Update backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #   [Integer] id - the entry id
      #
      # Request
      #   PATCH /backend/collections/:slug/entries/:id
      #   PATCH /backend/collections/:slug/entries/:id.json
      #   PUT   /backend/collections/:slug/entries/:id
      #   PUT   /backend/collections/:slug/entries/:id.json
      #
      # Paramaters
      #   {
      #     "collection_entry": {
      #       "value": {
      #         "field_key_1": "Field 1 Value",
      #         "field_key_2": "Field 2 Value"
      #       },
      #       "available_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def update
        @entry.update(resource_params)

        respond_with @entry, location: -> { location_after_update }
      end

      ##
      # Destroy backend collection entry
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the collection slug
      #   [Integer] id - the entry id
      #
      # Request
      #   DELETE /backend/collections/:slug/entries/:id
      #   DELETE /backend/collections/:slug/entries/:id.json
      #
      def destroy
        @entry.destroy

        respond_with @entry, location: -> { location_after_destroy }
      end

      ##
      # Update collection entry sort order
      #
      # Formats
      #   JSON
      #
      # Params
      #   [String] slug - the collection slug
      #
      # Request
      #   POST /backend/collections/:slug/entries/sort
      #   POST /backend/collections/:slug/entries/sort.json
      #
      # Paramaters
      #   {
      #     "collection_entry": {
      #       "sort": ["0" => "1234", "1" => "5678", "2" => "4321"]
      #     }
      #   }
      #
      def sort
        sort_order = sort_resource_params.fetch(:sort)

        ApplicationRecord.transaction do
          sort_order.each do |index, entry_id|
            entry = current_site.entries
                                .where(collection: @collection)
                                .find_by(id: entry_id.to_i)

            authorize entry

            entry.set_list_position(index)
          end
        end

        render json: { success: true }, status: :accepted
      end

      protected

      def permitted_attributes
        fields = @collection.fields.map { |record| record[:slug].to_sym }

        [
          :available_at,
          value: fields
        ]
      end

      def permitted_sort_attributes
        [
          sort: {}
        ]
      end

      def set_parent_resource
        collection_id = params.fetch(:collection_id)

        @collection = current_site.collections
                                  .find_by!(slug: collection_id)
      end

      def set_resources
        @entries = current_site.entries
                               .where(collection: @collection)
                               .page(page_num)
                               .per(per_page)

        authorize @entries
      end

      def set_resource
        resource_id = params.fetch(:id)

        @entry = current_site.entries
                             .where(collection: @collection)
                             .find_by!(id: resource_id)

        authorize @entry
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @entry = current_site.entries.new(new_params)

        authorize @entry
      end

      def resource_params
        params.require(resource_namespace)
              .permit(permitted_attributes)
              .merge(collection_id: @collection.id)
      end

      def sort_resource_params
        params.clone
              .require(resource_namespace)
              .permit(permitted_sort_attributes)
      end

      def resource_namespace
        :collection_entry
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
        backend_collection_entries_path(@collection)
      end
    end
  end
end
