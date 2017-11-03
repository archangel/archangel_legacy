# frozen_string_literal: true

module Archangel
  module Backend
    class WidgetsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @widgets
      end

      def show
        respond_with @widget
      end

      def new
        respond_with @widget
      end

      def create
        @widget.save

        respond_with @widget, location: -> { location_after_create }
      end

      def edit
        respond_with @widget
      end

      def update
        @widget.update(resource_params)

        respond_with @widget, location: -> { location_after_update }
      end

      def destroy
        @widget.destroy

        respond_with @widget, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content name slug template_id]
      end

      def set_resources
        @widgets = Archangel::Widget.order(name: :asc)
                                    .page(page_num)
                                    .per(per_page)

        authorize @widgets
      end

      def set_resource
        resource_id = params.fetch(:id)

        @widget = Archangel::Widget.find_by!(slug: resource_id)

        authorize @widget
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @widget = Archangel::Widget.new(new_params)

        authorize @widget
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
        backend_widgets_path
      end
    end
  end
end
