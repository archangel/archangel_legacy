# frozen_string_literal: true

module Archangel
  ##
  # Backend concerns
  #
  module Backend
    ##
    # Controller action concern
    #
    module ResourcefulConcern
      extend ActiveSupport::Concern

      ##
      # Backend [resources]
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/[resources]
      #   GET /backend/[resources].json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       ...
      #       "[param]": "...",
      #       ...
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        @resources = set_resources

        authorize @resources

        instance_variable_set("@#{resource_controller}", @resources)

        respond_with @resources
      end

      ##
      # Backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String|Integer] [param] - the [resource] param
      #
      # Request
      #   GET /backend/[resources]/:[param]
      #   GET /backend/[resources]/:[param].json
      #
      # Response
      #   {
      #     "id": 123,
      #     ...
      #     "[param]": "value",
      #     ...
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        @resource = set_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        respond_with @resource
      end

      ##
      # New backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/[resources]/new
      #   GET /backend/[resources]/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     ...
      #     "[param]": null,
      #     ...
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        @resource = set_new_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        respond_with @resource
      end

      ##
      # Create backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/[resources]
      #   POST /backend/[resources].json
      #
      # Paramaters
      #   {
      #     "[resource]": {
      #       ...
      #       "[param]": "value",
      #       ...
      #     }
      #   }
      #
      def create
        @resource = set_new_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        @resource.save

        respond_with @resource, location: -> { location_after_create }
      end

      ##
      # Edit backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String|Integer] [param] - the [resource] param
      #
      # Request
      #   GET /backend/[resources]/:[param]/edit
      #   GET /backend/[resources]/:[param]/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     ...
      #     "[param]": "value",
      #     ...
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        @resource = set_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        respond_with @resource
      end

      ##
      # Update backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String|Integer] [param] - the [resource] [param]
      #
      # Request
      #   PATCH /backend/[resources]/:[param]
      #   PATCH /backend/[resources]/:[param].json
      #   PUT   /backend/[resources]/:[param]
      #   PUT   /backend/[resources]/:[param].json
      #
      # Paramaters
      #   {
      #     "[resource]": {
      #       "...
      #       "[param]": "value",
      #       ...
      #     }
      #   }
      #
      def update
        @resource = set_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        @resource.update(resource_params)

        respond_with @resource, location: -> { location_after_update }
      end

      ##
      # Destroy backend [resource]
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String|Integer] [param] - the [resource] param
      #
      # Request
      #   DELETE /backend/[resources]/:[param]
      #   DELETE /backend/[resources]/:[param].json
      #
      def destroy
        @resource = set_resource

        authorize @resource

        instance_variable_set("@#{resource_model}", @resource)

        @resource.destroy

        respond_with @resource, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        []
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_controller
        controller_name.to_sym
      end

      def resource_model
        resource_namespace
      end

      def resource_namespace
        resource_controller.to_s.singularize.to_sym
      end

      def set_resources
        []
      end

      def set_resource
        nil
      end

      def set_new_resource
        nil
      end

      def location_after_create
        location_after_manage
      end

      def location_after_update
        location_after_manage
      end

      def location_after_destroy
        location_after_save
      end

      def location_after_manage
        location_after_save
      end

      def location_after_save
        resources_path
      end

      def resources_path(options = {})
        archangel.polymorphic_path([:backend, resource_controller], options)
      end
    end
  end
end
