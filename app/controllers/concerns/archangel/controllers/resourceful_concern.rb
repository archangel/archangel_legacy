# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Resourceful concern
    #
    module ResourcefulConcern
      extend ActiveSupport::Concern

      ##
      # Resources
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /resources
      #   GET /resources.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       ...
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        resources = resources_content

        respond_with resources
      end

      ##
      # Resource
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the resource ID
      #
      # Request
      #   GET /resources/:id
      #   GET /resources/:id.json
      #
      # Response
      #   {
      #     "id": 123,
      #     ...
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        resource = resource_content

        respond_with resource
      end

      ##
      # New resource
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /resources/new
      #   GET /resources/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     ...
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        resource = resource_new_content

        respond_with resource
      end

      ##
      # Create resource
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /resources
      #   POST /resources.json
      #
      # Paramaters
      #   {
      #     "resource": {
      #       "id": 123,
      #       ...
      #     }
      #   }
      #
      def create
        resource = resource_new_content

        resource.save unless resource.blank?

        respond_with resource, location: -> { location_after_create }
      end

      ##
      # Edit resource
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the resource ID
      #
      # Request
      #   GET /resources/:id/edit
      #   GET /resources/:id/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     ...
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        resource = resource_content

        respond_with resource
      end

      ##
      # Update resource
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the resource ID
      #
      # Request
      #   PATCH /resources/:id
      #   PATCH /resources/:id.json
      #   PUT   /resources/:id
      #   PUT   /resources/:id.json
      #
      # Paramaters
      #   {
      #     "resource": {
      #       "id": 123,
      #       ...
      #     }
      #   }
      #
      def update
        resource = resource_content

        resource.update(resource_params)

        respond_with resource, location: -> { location_after_update }
      end

      ##
      # Destroy resource
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the resource ID
      #
      # Request
      #   DELETE /resources/:id
      #   DELETE /resources/:id.json
      #
      def destroy
        resource = resource_content

        resource.destroy unless resource.blank?

        respond_with resource, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[]
      end

      def resources_content
        []
      end

      def resource_content
        {}
      end

      def resource_new_content
        action_name.to_sym == :create ? {} : nil
      end

      def resource_controller
        controller_name.to_sym
      end

      def resource_scope
        resource_controller.to_s.singularize.to_sym
      end

      def resource_namespace
        controller_path.split("/").second.to_sym
      end

      def resource_params
        params.require(resource_scope).permit(permitted_attributes)
      end

      def resource_new_params
        action_name.to_sym == :create ? resource_params : nil
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
        resources_path
      end

      def resources_path(options = {})
        location_path = [resource_namespace, resource_controller].compact

        archangel.polymorphic_path(location_path, options)
      end
    end
  end
end
