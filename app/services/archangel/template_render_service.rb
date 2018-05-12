# frozen_string_literal: true

module Archangel
  ##
  # Template Liquid render service
  #
  class TemplateRenderService < RenderService
    ##
    # Render the Liquid content for template
    #
    # @return [String] the rendered content for template
    #
    def call
      template_content = build_template(template)

      liquid = ::Liquid::Template.parse(template_content)
      liquid.send(:render, stringify_assigns, liquid_options).html_safe
    end

    protected

    def build_template(template)
      template_content = current_template_content(template)

      unless /\{\{\s*content_for_layout\s*\}\}/.match?(template_content)
        template_content += "{{ content_for_layout }}"
      end

      template_content
    end

    def current_template_content(template)
      return "{{ content_for_layout }}" if template.blank?

      template.content
    end
  end
end
