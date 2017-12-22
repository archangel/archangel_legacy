# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend templates controller
    #
    class TemplatesController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend templates
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/templates
      #   GET /backend/templates.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "parent_id": null,
      #       "name": "Template Name",
      #       "slug": "template_slug",
      #       "content": "</p>Content of Template 1</p>",
      #       "partial": false,
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @templates
      end

      ##
      # Backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the template id
      #
      # Request
      #   GET /backend/templates/:id
      #   GET /backend/templates/:id.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "parent_id": null,
      #     "name": "Template Name",
      #     "slug": "template_slug",
      #     "content": "</p>Content of Template</p>",
      #     "partial": false,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @template
      end

      ##
      # New backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/templates/new
      #   GET /backend/templates/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": 123,
      #     "parent_id": null,
      #     "name": null,
      #     "slug": null,
      #     "content": null,
      #     "partial": false,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @template
      end

      ##
      # Create backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/templates
      #   POST /backend/templates.json
      #
      # Paramaters
      #   {
      #     "template": {
      #       "parent_id": null,
      #       "name": "Template Name",
      #       "slug": "template_slug",
      #       "content": "</p>Content of Template</p>",
      #       "partial": false
      #     }
      #   }
      #
      def create
        @template.save

        respond_with @template, location: -> { location_after_create }
      end

      ##
      # Edit backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the template id
      #
      # Request
      #   GET /backend/templates/:id/edit
      #   GET /backend/templates/:id/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "parent_id": null,
      #     "name": "Template Name",
      #     "slug": "template_slug",
      #     "content": "</p>Content of Template</p>",
      #     "partial": false,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @template
      end

      ##
      # Update backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the template id
      #
      # Request
      #   PATCH /backend/templates/:id
      #   PATCH /backend/templates/:id.json
      #   PUT   /backend/templates/:id
      #   PUT   /backend/templates/:id.json
      #
      # Paramaters
      #   {
      #     "template": {
      #       "parent_id": null,
      #       "name": "Template Name",
      #       "slug": "template_slug",
      #       "content": "</p>Content of Template</p>",
      #       "partial": false
      #     }
      #   }
      #
      def update
        @template.update(resource_params)

        respond_with @template, location: -> { location_after_update }
      end

      ##
      # Destroy backend template
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the template id
      #
      # Request
      #   DELETE /backend/templates/:id
      #   DELETE /backend/templates/:id.json
      #
      def destroy
        @template.destroy

        respond_with @template, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content name parent_id partial]
      end

      def set_resources
        @templates = current_site.templates
                                 .order(name: :asc)
                                 .page(page_num).per(per_page)

        authorize @templates
      end

      def set_resource
        resource_id = params.fetch(:id)

        @template = current_site.templates.find_by!(id: resource_id)

        authorize @template
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @template = current_site.templates.new(new_params)

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
