# frozen_string_literal: true

module Archangel
  ##
  # Liquid render service
  #
  class RenderService
    ##
    # Variable assignments
    #
    attr_reader :assigns

    ##
    # Local filters
    #
    attr_reader :local_filters

    ##
    # Local registers
    #
    attr_reader :local_registers

    ##
    # Template to Liquidize
    #
    attr_reader :template

    ##
    # Liquid renderer
    #
    # @param template [String] the Liquid template
    # @param assigns [Object] the variable assignments
    # @param options [Object] the Liquid options
    #
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
      liquid.send(:render, stringify_assigns, liquid_options).html_safe
    end

    protected

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
