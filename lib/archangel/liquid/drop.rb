# frozen_string_literal: true

module Archangel
  ##
  # Archangel custom Liquid resources
  #
  module Liquid
    ##
    # Liquid Drop for singular resources
    #
    class Drop < ::Liquid::Drop
      class << self
        attr_accessor :_associations
        attr_accessor :_attributes
      end

      ##
      # Inherited objects
      #
      def self.inherited(base)
        base._associations = {}
        base._attributes = []
      end

      ##
      # Build attributes
      #
      def self.attributes(*attrs)
        @_attributes.concat attrs

        attrs.each do |attr|
          next if method_defined?(attr)

          define_method(attr) do
            object.send(attr) if object.methods.include?(attr)
          end
        end
      end

      attr_reader :object

      ##
      # Initialize
      #
      def initialize(object, _options = {})
        @object = object
      end
    end
  end
end
