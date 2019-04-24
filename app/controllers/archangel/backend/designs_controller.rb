# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend designs controller
    #
    class DesignsController < BackendController
      include Archangel::Controllers::ResourcefulConcern

      protected

      def permitted_attributes
        %w[content name parent_id partial]
      end

      def resources_content
        @designs = current_site.designs
                               .order(name: :asc)
                               .page(page_num).per(per_page)

        authorize @designs
      end

      def resource_content
        resource_id = params.fetch(:id)

        @design = current_site.designs.find_by!(id: resource_id)

        authorize @design
      end

      def resource_new_content
        @design = current_site.designs.new(resource_new_params)

        authorize @design
      end
    end
  end
end
