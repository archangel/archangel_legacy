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
      include Archangel::Controllers::Backend::ResourcefulConcern

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
      # Parameters
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
        asset = resource_wysiwyg_content

        asset.save

        asset_response = {
          success: true,
          url: asset.file.url
        }

        respond_to do |format|
          format.json { render json: asset_response }
        end
      end

      protected

      def permitted_attributes
        %w[file file_name]
      end

      def resources_content
        @assets = current_site.assets
                              .order(file_name: :asc)
                              .page(page_num).per(per_page)

        authorize @assets
      end

      def resource_content
        resource_id = params.fetch(:id)

        @asset = current_site.assets.find_by!(id: resource_id)

        authorize @asset
      end

      def resource_new_content
        @asset = current_site.assets.new(resource_new_params)

        authorize @asset
      end

      def resource_wysiwyg_content
        wysiwyg_params = params.permit(permitted_attributes).reverse_merge(
          file_name: "#{SecureRandom.hex}.jpg"
        )

        @asset = current_site.assets.new(wysiwyg_params)

        authorize @asset
      end
    end
  end
end
