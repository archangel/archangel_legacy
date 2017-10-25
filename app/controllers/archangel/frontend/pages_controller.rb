# frozen_string_literal: true

module Archangel
  module Frontend
    class PagesController < FrontendController
      before_action :set_resource, only: %i[show]

      def show
        return redirect_to_homepage if redirect_to_homepage?

        @page.content =
          content = liquify(@page.content, page: @page, site: current_site)

        respond_to do |format|
          format.html { render inline: content, layout: layout_from_theme }
          format.json
        end
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

      def redirect_to_homepage
        redirect_to root_path, status: :moved_permanently
      end

      def find_homepage
        Archangel::Page.published.homepage.first!
      end

      def find_page(path)
        Archangel::Page.published.find_by!(path: path)
      end

      def liquify(content, assigns = {})
        template = ::Liquid::Template.parse(content)

        template.send(liquid_renderer,
                      assigns.deep_stringify_keys,
                      liquid_options).html_safe
      end

      def liquid_renderer
        %w[development test].include?(Rails.env) ? :render! : :render
      end

      def liquid_options
        {
          filters: liquid_filters,
          registers: liquid_registers,
          error_mode: :lax,
          strict_variables: false,
          strict_filters: false
        }
      end

      def liquid_filters
        [Archangel::Frontend::PagesHelper]
      end

      def liquid_registers
        {
          view: self
        }
      end
    end
  end
end
