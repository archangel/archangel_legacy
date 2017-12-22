# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend widgets controller
    #
    class WidgetsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend widgets
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/widgets
      #   GET /backend/widgets.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "name": "Widget 1 Name",
      #       "slug": "widget_1_slug",
      #       "content": "</p>Content of Widget 1</p>",
      #       "template_id": 123,
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @widgets
      end

      ##
      # Backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the widget slug
      #
      # Request
      #   GET /backend/widgets/:slug
      #   GET /backend/widgets/:slug.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "Widget Name",
      #     "slug": "widget_slug",
      #     "content": "</p>Content of the Widget</p>",
      #     "template_id": 123,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @widget
      end

      ##
      # New backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/widgets/new
      #   GET /backend/widgets/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": 123,
      #     "name": null,
      #     "slug": null,
      #     "content": null,
      #     "template_id": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @widget
      end

      ##
      # Create backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/widgets
      #   POST /backend/widgets.json
      #
      # Paramaters
      #   {
      #     "widget": {
      #       "name": "Widget Name",
      #       "slug": "widget_slug",
      #       "content": "</p>Content of the Widget</p>",
      #       "template_id": 123
      #     }
      #   }
      #
      def create
        @widget.save

        respond_with @widget, location: -> { location_after_create }
      end

      ##
      # Edit backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the widget slug
      #
      # Request
      #   GET /backend/widgets/:slug/edit
      #   GET /backend/widgets/:slug/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "Widget Name",
      #     "slug": "widget_slug",
      #     "content": "</p>Content of the Widget</p>",
      #     "template_id": 123,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @widget
      end

      ##
      # Update backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the widget slug
      #
      # Request
      #   PATCH /backend/widgets/:slug
      #   PATCH /backend/widgets/:slug.json
      #   PUT   /backend/widgets/:slug
      #   PUT   /backend/widgets/:slug.json
      #
      # Paramaters
      #   {
      #     "widget": {
      #       "name": "Widget Name",
      #       "slug": "widget_slug",
      #       "content": "</p>Content of the Widget</p>",
      #       "template_id": 123
      #     }
      #   }
      #
      def update
        @widget.update(resource_params)

        respond_with @widget, location: -> { location_after_update }
      end

      ##
      # Destroy backend widget
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the widget slug
      #
      # Request
      #   DELETE /backend/widgets/:slug
      #   DELETE /backend/widgets/:slug.json
      #
      def destroy
        @widget.destroy

        respond_with @widget, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[content name slug template_id]
      end

      def set_resources
        @widgets = current_site.widgets
                               .order(name: :asc)
                               .page(page_num).per(per_page)

        authorize @widgets
      end

      def set_resource
        resource_id = params.fetch(:id)

        @widget = current_site.widgets.find_by!(slug: resource_id)

        authorize @widget
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @widget = current_site.widgets.new(new_params)

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
