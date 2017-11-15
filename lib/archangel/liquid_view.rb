# frozen_string_literal: true

module Archangel
  class LiquidView
    def self.call(template)
      "Archangel::LiquidView.new(self).render(
        #{template.source.inspect}, local_assigns)"
    end

    def initialize(view)
      @view = view
    end

    def render(template, local_assigns = {})
      @view.controller.headers["Content-Type"] ||= "text/html; charset=utf-8"

      assigns = _assigns(local_assigns)
      options = { filters: _filters, registers: _registers }

      Archangel::Liquid::RenderService.call(template, assigns, options)
    end

    def compilable?
      false
    end

    protected

    def _assigns(local_assigns)
      assigns = @view.assigns

      if @view.content_for?(:layout)
        assigns["content_for_layout"] = @view.content_for(:layout)
      end

      assigns.merge(local_assigns.stringify_keys)
    end

    def _controller
      @view.controller
    end

    def _filters
      extra_filters = []

      controller_class = _controller.class

      if controller_class.respond_to? :liquid_filters
        controller_class.liquid_filters.each do |method|
          extra_filters.merge! _controller.send(method)
        end
      end

      extra_filters
    end

    def _registers
      extra_registers = {}

      controller_class = _controller.class

      if controller_class.respond_to? :liquid_registers
        controller_class.liquid_registers.each do |method|
          extra_registers.merge! _controller.send(method)
        end
      end

      {
        view: @view,
        controller: _controller,
        helper: ActionController::Base.helpers
      }.merge extra_registers
    end
  end
end
