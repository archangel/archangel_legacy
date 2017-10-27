# frozen_string_literal: true

module Archangel
  module Backend
    class TemplatesController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @templates
      end

      def show
        respond_with @template
      end

      def new
        respond_with @template
      end

      def create
        @template.save

        respond_with @template, location: -> { location_after_create }
      end

      def edit
        respond_with @template
      end

      def update
        @template.update(resource_params)

        respond_with @template, location: -> { location_after_update }
      end

      def destroy
        @template.destroy

        respond_with @template, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content name parent_id partial]
      end

      def set_resources
        @templates = Archangel::Template.page(page_num).per(per_page)

        authorize @templates
      end

      def set_resource
        @template = Archangel::Template.find_by!(id: params[:id])

        authorize @template
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @template = Archangel::Template.new(new_params)

        authorize @template
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
        backend_templates_path
      end
    end
  end
end
