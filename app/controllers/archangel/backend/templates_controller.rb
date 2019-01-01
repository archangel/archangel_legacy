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
      include Archangel::Controllers::Backend::ResourcefulConcern

      protected

      def permitted_attributes
        %w[content name parent_id partial]
      end

      def resources_content
        @templates = current_site.templates
                                 .order(name: :asc)
                                 .page(page_num).per(per_page)

        authorize @templates
      end

      def resource_content
        resource_id = params.fetch(:id)

        @template = current_site.templates.find_by!(id: resource_id)

        authorize @template
      end

      def resource_new_content
        @template = current_site.templates.new(resource_new_params)

        authorize @template
      end
    end
  end
end
