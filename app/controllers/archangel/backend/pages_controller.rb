# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend pages controller
    #
    class PagesController < BackendController
      include Archangel::Controllers::Backend::ResourcefulConcern

      protected

      def permitted_attributes
        %w[content homepage meta_description meta_keywords parent_id path
           published_at slug template_id title]
      end

      def resources_content
        @pages = current_site.pages
                             .order(title: :asc)
                             .page(page_num).per(per_page)

        authorize @pages
      end

      def resource_content
        resource_id = params.fetch(:id)

        @page = current_site.pages.find_by!(id: resource_id)

        authorize @page
      end

      def resource_new_content
        @page = current_site.pages.new(resource_new_params)

        authorize @page
      end
    end
  end
end
