# frozen_string_literal: true

module Archangel
  module Frontend
    class PagesController < FrontendController
      before_action :set_resource, only: %i[show]
      before_action :assign_meta_tags, if: -> { request.get? },
                                       unless: -> { request.xhr? }

      def show
        return redirect_to_homepage if redirect_to_homepage?

        @page.content = content = liquid_rendered_content

        respond_to do |format|
          format.html { render inline: content, layout: layout_from_theme }
          format.json { render json: @page, layout: false }
        end
      end

      protected

      def set_resource
        page_path = params.fetch(:path, nil)

        @page = page_path.blank? ? find_homepage : find_page(page_path)
      end

      def assign_meta_tags
        apply_meta_tags title: @page.title,
                        description: @page.meta_description,
                        keywords: @page.meta_keywords.to_s.split(",")
      end

      def redirect_to_homepage?
        return false unless @page

        (params.fetch(:path, nil) == @page.path) && @page.homepage?
      end

      def redirect_to_homepage
        redirect_to root_path, status: :moved_permanently
      end

      def find_homepage
        current_site.pages.published.homepage.first!
      end

      def find_page(path)
        current_site.pages.published.find_by!(path: path)
      end

      def liquid_rendered_content
        Archangel::Liquid::RenderService.call(@page.content,
                                              page: @page,
                                              site: current_site)
      end
    end
  end
end
