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
      default_controller.headers["Content-Type"] ||= "text/html; charset=utf-8"

      assigns = default_assigns(local_assigns)
      options = { registers: default_registers }

      Archangel::RenderService.call(template, assigns, options)
    end

    protected

    def default_controller
      @view.controller
    end

    def default_assigns(local_assigns)
      assigns = @view.assigns

      if @view.content_for?(:layout)
        assigns["content_for_layout"] = @view.content_for(:layout)
      end

      assigns.merge(local_assigns.stringify_keys)
    end

    def default_registers
      {
        view: @view,
        controller: default_controller,
        helper: ActionController::Base.helpers
      }
    end
  end
end
