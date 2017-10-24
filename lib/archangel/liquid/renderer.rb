# frozen_string_literal: true

module Archangel
  module Liquid
    class Renderer
      def initialize(view)
        @view = view
      end

      def self.call(template)
        "Archangel::Liquid::Renderer.new(self).render(" \
          "#{template.source.inspect}, local_assigns)"
      end

      def render(template, local_assigns = {})
        assigns = _merge_assigns(local_assigns)

        liquid = ::Liquid::Template.parse(template)
        liquid.render(assigns, filters: _filters, registers: _registers)
      end

      def compilable?
        false
      end

      private

      def _merge_assigns(local_assigns)
        assigns = @view.assigns

        if @view.content_for?(:layout)
          assigns["content_for_layout"] = @view.content_for(:layout)
        end

        assigns.merge!(local_assigns.stringify_keys)
      end

      def _controller
        @view.controller
      end

      def _filters
        extra_filters = []

        if _controller.class.respond_to? :liquid_filters
          _controller.class.liquid_filters.each do |method|
            extra_filters.merge! _controller.send(method)
          end
        end

        [] + extra_filters
      end

      def _registers
        extra_registers = {}

        if _controller.class.respond_to? :liquid_registers
          _controller.class.liquid_registers.each do |method|
            extra_registers.merge! _controller.send(method)
          end
        end

        {
          view: @view,
          controller: _controller
        }.merge extra_registers
      end
    end
  end
end

ActionView::Template.register_template_handler :liquid,
                                               Archangel::Liquid::Renderer
