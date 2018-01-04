# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::FrontendController
  #
  module Frontend
    ##
    # Frontend pages controller
    #
    class PagesController < FrontendController
      before_action :set_resource, only: %i[show]
      before_action :assign_meta_tags, if: -> { request.get? },
                                       unless: -> { request.xhr? }

      ##
      # Frontend page
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] path - the path to the page
      #
      # Request
      #   GET /:path
      #   GET /:path.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "path": "path/to/page",
      #     "content": "</p>Content of the page</p>",
      #     "homepage": false,
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #   }
      #
      def show
        return redirect_to_homepage if redirect_to_homepage?

        respond_to do |format|
          format.html do
            render inline: liquid_rendered_template_content,
                   layout: layout_from_theme
          end
          format.json do
            @page.content = liquid_rendered_content

            render json: @page, layout: false
          end
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

      def liquid_rendered_template_content
        content = liquid_rendered_content

        Archangel::Liquid::TemplateRenderService.call(
          @page.template,
          content_for_layout: content
        )
      end
    end
  end
end
