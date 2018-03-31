# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend assets controller
    #
    class AssetsController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]
      before_action :set_wysiwyg_resource, only: %i[wysiwyg]

      ##
      # Backend assets
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/assets
      #   GET /backend/assets.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "file_name": "file_name.gif",
      #       "file": {
      #         "url": "/uploads/file.gif",
      #         "small": {
      #           "url": "/uploads/small_file.gif"
      #         },
      #         "tiny": {
      #           "url": "/uploads/tiny_file.gif"
      #         }
      #       },
      #       "content_type": "image/gif",
      #       "file_size": 1234,
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @assets
      end

      ##
      # Backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the asset id
      #
      # Request
      #   GET /backend/assets/:id
      #   GET /backend/assets/:id.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "file_name": "file_name.gif",
      #     "file": {
      #       "url": "/uploads/file.gif",
      #       "small": {
      #         "url": "/uploads/small_file.gif"
      #       },
      #       "tiny": {
      #         "url": "/uploads/tiny_file.gif"
      #       }
      #     },
      #     "content_type": "image/gif",
      #     "file_size": 1234,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @asset
      end

      ##
      # New backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/assets/new
      #   GET /backend/assets/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": null,
      #     "file_name": null,
      #     "file": {
      #       "url": null,
      #       "small": {
      #         "url": null
      #       },
      #       "tiny": {
      #         "url": null
      #       }
      #     },
      #     "content_type": null,
      #     "file_size": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @asset
      end

      ##
      # Create backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/assets
      #   POST /backend/assets.json
      #
      # Paramaters
      #   {
      #     "asset": {
      #       "file_name": "file_name.gif",
      #       "file": "local/path/to/new_file.gif"
      #     }
      #   }
      #
      def create
        @asset.save

        respond_with @asset, location: -> { location_after_create }
      end

      ##
      # Edit backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the asset id
      #
      # Request
      #   GET /backend/assets/:id/edit
      #   GET /backend/assets/:id/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "file_name": "file_name.gif",
      #     "file": {
      #       "url": "/uploads/file.gif",
      #       "small": {
      #         "url": "/uploads/small_file.gif"
      #       },
      #       "tiny": {
      #         "url": "/uploads/tiny_file.gif"
      #       }
      #     },
      #     "content_type": "image/gif",
      #     "file_size": 1234,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @asset
      end

      ##
      # Update backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the asset id
      #
      # Request
      #   PATCH /backend/assets/:id
      #   PATCH /backend/assets/:id.json
      #   PUT   /backend/assets/:id
      #   PUT   /backend/assets/:id.json
      #
      # Paramaters
      #   {
      #     "asset": {
      #       "file_name": "file_name.gif",
      #       "file": "local/path/to/new_file.gif"
      #       }
      #     }
      #   }
      #
      def update
        @asset.update(resource_params)

        respond_with @asset, location: -> { location_after_update }
      end

      ##
      # Destroy backend asset
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [Integer] id - the asset id
      #
      # Request
      #   DELETE /backend/assets/:id
      #   DELETE /backend/assetsidslug.json
      #
      def destroy
        @asset.destroy

        respond_with @asset, location: -> { location_after_destroy }
      end

      ##
      # Create backend asset from WYSIWYG upload
      #
      # Formats
      #   JSON
      #
      # Request
      #   POST /backend/wysiwyg
      #   POST /backend/wysiwyg.json
      #
      # Paramaters
      #   {
      #     "file": "local/path/to/new_file.gif"
      #   }
      #
      # Response
      #   {
      #     "success": true,
      #     "url": "file_name.gif"
      #   }
      #
      def wysiwyg
        @asset.save

        asset_response = {
          success: true,
          url: @asset.file.url
        }

        respond_to do |format|
          format.json { render json: asset_response }
        end
      end

      protected

      def permitted_attributes
        %w[file file_name]
      end

      def set_resources
        @assets = current_site.assets
                              .order(file_name: :asc)
                              .page(page_num).per(per_page)

        authorize @assets
      end

      def set_resource
        resource_id = params.fetch(:id)

        @asset = current_site.assets.find_by!(id: resource_id)

        authorize @asset
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @asset = current_site.assets.new(new_params)

        authorize @asset
      end

      def set_wysiwyg_resource
        wysiwyg_params = params.permit(permitted_attributes).reverse_merge(
          file_name: "#{SecureRandom.hex}.jpg"
        )

        @asset = current_site.assets.new(wysiwyg_params)

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
