# frozen_string_literal: true

module Archangel
  module Backend
    class SitesController < BackendController
      before_action :set_resource

      def show
        respond_with @site
      end

      def edit
        respond_with @site
      end

      def update
        @site.update(resource_params)

        respond_with @site, location: -> { location_after_update }
      end

      protected

      def permitted_attributes
        %w[favicon locale logo meta_description meta_keywords name theme]
      end

      def set_resource
        @site = current_site

        authorize @site
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        :site
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
