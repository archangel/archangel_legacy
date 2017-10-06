# frozen_string_literal: true

module Archangel
  module Backend
    class CollectionsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @collections
      end

      def show
        respond_with @collection
      end

      def new
        respond_with @collection
      end

      def create
        @collection.save

        respond_with @collection, location: -> { location_after_create }
      end

      def edit
        respond_with @collection
      end

      def update
        @collection.update(resource_params)

        respond_with @collection, location: -> { location_after_update }
      end

      def destroy
        @collection.destroy

        respond_with @collection, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %i[name slug]
      end

      def set_resources
        @collections = Archangel::Collection.page(page_num).per(per_page)

        authorize @collections
      end

      def set_resource
        @collection = Archangel::Collection.find_by!(slug: params[:id])

        authorize @collection
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @collection = Archangel::Collection.new(new_params)

        authorize @collection
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        :collection
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
