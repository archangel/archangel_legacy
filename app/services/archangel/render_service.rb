# frozen_string_literal: true

module Archangel
  ##
  # Liquid render service
  #
  class RenderService
    attr_reader :assigns, :local_filters, :local_registers, :template

    def initialize(template, assigns = {}, options = {})
      @template = template
      @assigns = assigns
      @local_filters = options.fetch(:filters, [])
      @local_registers = options.fetch(:registers, {})
    end

    ##
    # Render the Liquid content
    #
    # @param template [String] the content
    # @param assigns [Hash] the local variables
    # @param options [Hash] the options
    # @return [String] the rendered content
    #
    def self.call(template, assigns = {}, options = {})
      new(template, assigns, options).call
    end

    ##
    # Render the Liquid content
    #
    # @return [String] the rendered content
    #
    def call
      liquid = ::Liquid::Template.parse(template)
      liquid.send(liquid_renderer,
                  stringify_assigns,
                  liquid_options).html_safe
    end

    protected

    def liquid_renderer
      %w[development test].include?(Rails.env) ? :render! : :render
    end

    def stringify_assigns
      assigns.deep_stringify_keys
    end

    def liquid_options
      {
        filters: local_filters,
        registers: local_registers,
        error_mode: error_mode,
        strict_variables: strict_variables,
        strict_filters: strict_filters
      }
    end

    def error_mode
      :lax
    end

    def strict_variables
      false
    end

    def strict_filters
      false
    end
  end
end
