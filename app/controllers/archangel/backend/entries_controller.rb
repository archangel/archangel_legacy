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
      include Archangel::Controllers::ResourcefulConcern

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
        parent_resource_content

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

      def parent_resource_content
        collection_id = params.fetch(:collection_id)

        @collection = current_site.collections
                                  .find_by!(slug: collection_id)
      end

      def resources_content
        parent_resource_content

        @entries = current_site.entries
                               .where(collection: @collection)
                               .page(page_num)
                               .per(per_page)

        authorize @entries
      end

      def resource_content
        parent_resource_content

        resource_id = params.fetch(:id)

        @entry = current_site.entries
                             .where(collection: @collection)
                             .find_by!(id: resource_id)

        authorize @entry
      end

      def resource_new_content
        parent_resource_content

        @entry = current_site.entries.new(resource_new_params)

        authorize @entry
      end

      def resource_namespace
        :collection_entry
      end

      def location_after_save
        backend_collection_entries_path(@collection)
      end
    end
  end
end
