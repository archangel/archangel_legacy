# frozen_string_literal: true

module Archangel
  module Backend
    class PagesController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @pages
      end

      def show
        respond_with @page
      end

      def new
        respond_with @page
      end

      def create
        @page.save

        respond_with @page, location: -> { location_after_create }
      end

      def edit
        respond_with @page
      end

      def update
        @page.update(resource_params)

        respond_with @page, location: -> { location_after_update }
      end

      def destroy
        @page.destroy

        respond_with @page, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content homepage parent_id path published_at slug template_id title]
      end

      def set_resources
        @pages = Archangel::Page.order(title: :asc)
                                .page(page_num)
                                .per(per_page)

        authorize @pages
      end

      def set_resource
        @page = Archangel::Page.find_by!(id: params[:id])

        authorize @page
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @page = Archangel::Page.new(new_params)

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
