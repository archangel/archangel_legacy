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
      include Archangel::Controllers::ResourcefulConcern

      protected

      def permitted_resource_attributes
        %w[content design_id name slug]
      end

      def resources_content
        @widgets = current_site.widgets
                               .order(name: :asc)
                               .page(page_num).per(per_page)

        authorize @widgets
      end

      def resource_content
        resource_id = params.fetch(:id)

        @widget = current_site.widgets.find_by!(slug: resource_id)

        authorize @widget
      end

      def resource_new_content
        @widget = current_site.widgets.new(resource_new_params)

        authorize @widget
      end
    end
  end
end
