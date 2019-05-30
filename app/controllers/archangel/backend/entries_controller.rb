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

      before_action :parent_resource_content

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
      # Parameters
      #   {
      #     "collection_entry": {
      #       "sort": ["0" => "1234", "1" => "5678", "2" => "4321"]
      #     }
      #   }
      #
      def sort
        ApplicationRecord.transaction do
          sort_resource_params.fetch(:sort, []).each do |index, entry_id|
            entry = current_site.entries
                                .where(collection: @collection)
                                .find_by(id: entry_id.to_i)

            authorize entry

            entry.set_list_position(index)
          end
        end

        render json: { status: :accepted, success: true }, status: :accepted
      end

      protected

      def permitted_attributes
        fields = @collection.fields.map(&:slug).map(&:to_sym)

        fields + %i[published_at]
      end

      def permitted_sort_attributes
        [
          sort: {}
        ]
      end

      def sort_resource_params
        params.clone.require(resource_scope).permit(permitted_sort_attributes)
      end

      def parent_resource_content
        collection_id = params.fetch(:collection_id)

        @collection = current_site.collections
                                  .find_by!(slug: collection_id)
      end

      def resources_content
        @entries = current_site.entries
                               .where(collection: @collection)
                               .page(page_num)
                               .per(per_page)

        authorize @entries
      end

      def resource_content
        resource_id = params.fetch(:id)

        @entry = current_site.entries
                             .where(collection: @collection)
                             .find_by!(id: resource_id)

        authorize @entry
      end

      def resource_new_content
        @entry = current_site.entries.where(collection: @collection).new(nil)

        if action_name.to_sym == :create
          @collection.fields.map(&:slug).each do |field|
            @entry.assign_attributes(field => resource_params.fetch(field, nil))
          end
        end

        authorize @entry
      end

      def resource_scope
        :collection_entry
      end

      def location_after_save
        backend_collection_entries_path(@collection)
      end
    end
  end
end
