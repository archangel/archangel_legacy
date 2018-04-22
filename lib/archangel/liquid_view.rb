# frozen_string_literal: true

module Archangel
  ##
  # Liquid view renderer
  #
  class LiquidView
    ##
    # Liquid view
    #
    # @param view [String] the view
    #
    def initialize(view)
      @view = view
    end

    ##
    # Render Liquid content
    #
    # @param template [String] the content
    # @return [String] the rendered content
    #
    def self.call(template)
      "Archangel::LiquidView.new(self).render(
        #{template.source.inspect}, local_assigns)"
    end

    ##
    # Render Liquid content
    #
    # @param template [String] the content
    # @param local_assigns [Hash] the local assigned variables
    # @return [String] the rendered content
    #
    def render(template, local_assigns = {})
      @view.controller.headers["Content-Type"] ||= "text/html; charset=utf-8"

      assigns = default_assigns(local_assigns)
      options = { filters: default_filters, registers: default_registers }

      Archangel::RenderService.call(template, assigns, options)
    end

    protected

    def default_assigns(local_assigns)
      assigns = @view.assigns

      if @view.content_for?(:layout)
        assigns["content_for_layout"] = @view.content_for(:layout)
      end

      assigns.merge(local_assigns.stringify_keys)
    end

    def default_controller
      @view.controller
    end

    def default_filters
      extra_filters = []

      controller_class = default_controller.class

      if controller_class.respond_to?(:liquid_filters)
        controller_class.liquid_filters.each do |method|
          extra_filters.merge! default_controller.send(method)
        end
      end

      extra_filters
    end

    def default_registers
      extra_registers = {}

      controller_class = default_controller.class

      if controller_class.respond_to?(:liquid_registers)
        controller_class.liquid_registers.each do |method|
          extra_registers.merge! default_controller.send(method)
        end
      end

      {
        view: @view,
        controller: default_controller,
        helper: ActionController::Base.helpers
      }.merge extra_registers
    end
  end
end
