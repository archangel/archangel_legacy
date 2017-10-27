# frozen_string_literal: true

module Archangel
  module Backend
    class AssetsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @assets
      end

      def show
        respond_with @asset
      end

      def new
        respond_with @asset
      end

      def create
        @asset.save

        respond_with @asset, location: -> { location_after_create }
      end

      def edit
        respond_with @asset
      end

      def update
        @asset.update(resource_params)

        respond_with @asset, location: -> { location_after_update }
      end

      def destroy
        @asset.destroy

        respond_with @asset, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[file file_name]
      end

      def set_resources
        @assets = Archangel::Asset.page(page_num).per(per_page)

        authorize @assets
      end

      def set_resource
        @asset = Archangel::Asset.find_by!(id: params[:id])

        authorize @asset
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @asset = Archangel::Asset.new(new_params)

        authorize @asset
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
        backend_assets_path
      end
    end
  end
end
