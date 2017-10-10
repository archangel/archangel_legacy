# frozen_string_literal: true

module Archangel
  module Frontend
    class PagesController < FrontendController
      before_action :set_resource, only: %i[show]

      def show
        if redirect_to_homepage?
          return redirect_to root_path, status: :moved_permanently
        end

        respond_with @page
      end

      protected

      def set_resource
        page_path = params.fetch(:path, nil)

        @page = page_path.blank? ? find_homepage : find_page(page_path)
      end

      def redirect_to_homepage?
        return false unless @page

        (params.fetch(:path, nil) == @page.path) && @page.homepage?
      end

      def find_homepage
        Archangel::Page.published.homepage.first!
      end

      def find_page(path)
        Archangel::Page.published.find_by!(path: path)
      end
    end
  end
end
