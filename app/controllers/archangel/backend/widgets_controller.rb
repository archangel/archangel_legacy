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
      include Archangel::Backend::ResourcefulConcern

      protected

      def permitted_attributes
        %w[content name slug template_id]
      end

      def set_resources
        current_site.widgets.order(name: :asc).page(page_num).per(per_page)
      end

      def set_resource
        resource_id = params.fetch(:id)

        current_site.widgets.find_by!(slug: resource_id)
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        current_site.widgets.new(new_params)
      end
    end
  end
end
