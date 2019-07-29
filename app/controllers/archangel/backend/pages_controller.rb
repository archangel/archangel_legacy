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
      include Archangel::Controllers::ResourcefulConcern

      helper Archangel::Backend::MetatagsHelper

      protected

      def permitted_attributes
        [
          :content, :design_id, :homepage, :parent_id, :permalink,
          :published_at, :slug, :title,
          metatags_attributes: %i[id _destroy name content]
        ]
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

        @page.metatags.build if @page.metatags.blank?

        authorize @page
      end
    end
  end
end
