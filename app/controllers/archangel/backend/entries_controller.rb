# frozen_string_literal: true

module Archangel
  module Backend
    class EntriesController < BackendController
      before_action :set_parent_resource
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @entries
      end

      def show
        respond_with @entry
      end

      def new
        respond_with @entry
      end

      def create
        @entry.save

        respond_with @entry, location: -> { location_after_create }
      end

      def edit
        respond_with @entry
      end

      def update
        @entry.update(resource_params)

        respond_with @entry, location: -> { location_after_update }
      end

      def destroy
        @entry.destroy

        respond_with @entry, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        fields = @collection.fields.map { |record| record[:slug].to_sym }

        [
          :available_at,
          value: fields
        ]
      end

      def set_parent_resource
        collection_id = params.fetch(:collection_id)

        @collection = current_site.collections
                                  .find_by!(slug: collection_id)
      end

      def set_resources
        @entries = current_site.entries
                               .order(position: :asc)
                               .page(page_num).per(per_page)

        authorize @entries
      end

      def set_resource
        resource_id = params.fetch(:id)

        @entry = current_site.entries.find_by!(id: resource_id)

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
