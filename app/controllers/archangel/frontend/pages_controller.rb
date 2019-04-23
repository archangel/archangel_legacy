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
      before_action :assign_resource_meta_tags, if: -> { request.get? },
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
      #     "permalink": "/path/to/page",
      #     "content": "</p>Content of the page</p>",
      #     "homepage": false,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #   }
      #
      def show
        return redirect_to_homepage if redirect_to_homepage?

        @page.content = liquid_rendered_template_content

        respond_to do |format|
          format.html do
            render(inline: @page.content, layout: layout_from_theme)
          end
          format.json do
            render(template: "archangel/frontend/pages/show", layout: false)
          end
        end
      end

      protected

      ##
      # Find and assign resource to the view
      #
      def set_resource
        page_permalink = params.fetch(:permalink, nil)

        @page = current_site.pages.available.find_by!(permalink: page_permalink)
      end

      ##
      # Assign meta tags to view
      #
      def assign_resource_meta_tags
        assign_meta_tags(resource_meta_tags)
      end

      ##
      # Meta tags for the page
      #
      # @return [Object] the page meta tags
      #
      def resource_meta_tags
        meta_tags = [
          current_site.metatags,
          @page.metatags
        ].flatten.inject({}) do |tags, metatag|
          tags.merge(metatag.name => metatag.content)
        end

        { image_src: current_site.logo.url }.merge(meta_tags)
                                            .merge(title: @page.title)
      end

      ##
      # Check to redirect to homepage root permalink
      #
      # @return [Boolean] redirect or not
      #
      def redirect_to_homepage?
        @page.homepage?
      end

      ##
      # Redirect to homepage root permalink is page is marked as the homepage
      #
      def redirect_to_homepage
        redirect_to frontend_root_path, status: :moved_permanently
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
