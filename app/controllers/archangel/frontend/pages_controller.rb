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

      ##
      # Find and assign resource to the view
      #
      def set_resource
        page_path = params.fetch(:path, nil)

        @page = page_path.blank? ? find_homepage : find_page(page_path)
      end

      ##
      # Assign meta tags to view
      #
      def assign_meta_tags
        apply_meta_tags(page_meta_tags)
      end

      ##
      # Meta tags for the page
      #
      # @return [Object] the page meta tags
      #
      def page_meta_tags
        {
          title: @page.title,
          description: @page.meta_description,
          keywords: @page.meta_keywords.to_s.split(",")
        }
      end

      ##
      # Check to redirect to homepage root path
      #
      # @return [Boolean] redirect or not
      #
      def redirect_to_homepage?
        return false unless @page

        (params.fetch(:path, nil) == @page.path) && @page.homepage?
      end

      ##
      # Redirect to homepage root path is page is marked as the homepage
      #
      def redirect_to_homepage
        redirect_to root_path, status: :moved_permanently
      end

      ##
      # Find the homepage
      #
      # @return [Object] the homepage
      #
      def find_homepage
        current_site.pages.published.homepage.first!
      end

      ##
      # Find the requested page
      #
      # @return [Object] the page
      #
      def find_page(path)
        current_site.pages.published.find_by!(path: path)
      end

      ##
      # Render content
      #
      # @return [String] the rendered Liquid content
      #
      def liquid_rendered_content
        variables = default_liquid_assign

        Archangel::RenderService.call(@page.content, variables)
      end

      ##
      # Render content with template
      #
      # @return [String] the rendered Liquid template
      #
      def liquid_rendered_template_content
        content = liquid_rendered_content
        variables = default_liquid_assign.merge(content_for_layout: content)

        Archangel::TemplateRenderService.call(@page.template, variables)
      end

      def default_liquid_assign
        {
          current_page: request.fullpath,
          page: @page.to_liquid,
          site: current_site.to_liquid
        }
      end
    end
  end
end
