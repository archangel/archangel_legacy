# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend collections controller
    #
    class CollectionsController < BackendController
      include Archangel::Controllers::Backend::ResourcefulConcern

      protected

      def permitted_attributes
        [
          :name, :slug,
          fields_attributes: %i[id _destroy classification label required slug]
        ]
      end

      def resources_content
        @collections = current_site.collections
                                   .order(name: :asc)
                                   .page(page_num).per(per_page)

        authorize @collections
      end

      def resource_content
        resource_id = params.fetch(:id)

        @collection = current_site.collections.find_by!(slug: resource_id)

        authorize @collection
      end

      def resource_new_content
        @collection = current_site.collections.new(resource_new_params)

        @collection.fields.build unless @collection.fields.present?

        authorize @collection
      end
    end
  end
end
