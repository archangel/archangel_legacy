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
      #   [String] permalink - the permalink to the page
      #
      # Request
      #   GET /:permalink
      #   GET /:permalink.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "permalink": "path/to/page",
      #     "content": "</p>Content of the page</p>",
      #     "homepage": false,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #   }
      #
      def show
        return redirect_to_homepage if redirect_to_homepage?

        respond_to do |format|
          format.html do
            render inline: liquid_rendered_design_content,
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
        page_permalink = params.fetch(:permalink, nil)

        @page = if page_permalink.blank?
                  find_homepage
                else
                  find_page(page_permalink)
                end
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
        [
          current_site.metatags,
          @page.metatags
        ].flatten.inject({}) do |tags, metatag|
          tags.merge(metatag.name => metatag.content)
        end.merge(title: @page.title)
      end

      ##
      # Check to redirect to homepage root permalink
      #
      # @return [Boolean] redirect or not
      #
      def redirect_to_homepage?
        return false unless @page

        (params.fetch(:permalink, nil) == @page.permalink) && @page.homepage?
      end

      ##
      # Redirect to homepage root permalink is page is marked as the homepage
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
      def find_page(permalink)
        current_site.pages.published.find_by!(permalink: permalink)
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
      # Render content with design
      #
      # @return [String] the rendered Liquid template
      #
      def liquid_rendered_design_content
        content = liquid_rendered_content
        variables = default_liquid_assign.merge(content_for_layout: content)

        Archangel::DesignRenderService.call(@page.design, variables)
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
