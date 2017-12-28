# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Liquid Drop for collection resources
    #
    class CollectionDrop < ::Liquid::Drop
      class << self
        attr_accessor :_scopes
      end

      def self.inherited(base)
        base._scopes = []
      end

      def self.scope(*scope_names)
        @_scopes.concat scope_names

        scope_names.each do |scope_name|
          define_method(scope_name) do
            value = instance_variable_get("@_#{scope_name}")
            return value if value

            unless objects.respond_to?(scope_name)
              raise ArgumentError,
                    "#{objects.class.name} doesn't define scope: #{scope_name}"
            end

            instance_variable_set("@_#{scope_name}",
                                  self.class.new(objects.send(scope_name)))
          end
        end
      end

      array_methods = Array.instance_methods - Object.instance_methods
      delegate *array_methods, to: :dropped_collection
      delegate :total_count, :total_pages, to: :objects

      def initialize(objects, options = {})
        options.assert_valid_keys(:with, :scope)

        @objects = options[:scope].nil? ? objects : objects.send(options[:scope])
        @drop_class_name = options[:with]
      end

      def page(number)
        self.class.new(objects.page(number))
      end

      def per(number)
        self.class.new(objects.per(number))
      end

      def dropped_collection
        @dropped_collection ||= @objects.map { |item| drop_item(item) }
      end

      def kind_of?(klass)
        dropped_collection.is_a?(klass) || super
      end
      alias is_a? kind_of?

      def [](method)
        if method.is_a?(Integer)
          dropped_collection.at(method)
        else
          public_send(method)
        end
      end

      def to_liquid
        self
      end

      def inspect
        "#<#{self.class.name} of #{drop_class} for #{objects.inspect}>"
      end

      protected

      attr_reader :objects

      def drop_class
        @drop_class ||= drop_class_format
      end

      def drop_class_format
        return @drop_class_name if @drop_class_name.is_a?(String)

        @drop_class_name.safe_constantize
      end

      def drop_item(item)
        liquid_drop_class = drop_class || item.drop_class
        liquid_drop_class.new(item)
      end
    end
  end
end
