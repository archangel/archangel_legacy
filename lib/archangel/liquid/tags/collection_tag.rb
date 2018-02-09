# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Collection custom tag for Liquid to set a variable for Collections
      #
      # Example
      #   {% collection things = 'my-collection' %}
      #   {% for item in things %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endfor %}
      #
      #   {% collection things = 'my-collection' limit:5 offset:25 %}
      #   {% for item in things %}
      #     {{ forloop.index }}: {{ item.name }}
      #   {% endfor %}
      #
      class CollectionTag < ApplicationTag
        ##
        # {% collection key = 'value' options %}
        #
        SYNTAX = /
          (?<key>#{::Liquid::VariableSignature}+)
          \s*
          =
          \s*
          (?<value>#{::Liquid::QuotedFragment}+)
          \s*
          (?<attributes>.*)
          \s*
        /omx

        ##
        # {% collection key = 'value' options %}
        #
        SYNTAX_ATTRIBUTES = /
          (?<key>\w+)
          \s*
          \:
          \s*
          (?<value>#{::Liquid::QuotedFragment})
        /ox

        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          if match.blank?
            raise SyntaxError, Archangel.t("errors.syntax.collection")
          end

          @key = match[:key]
          @value = ::Liquid::Variable.new(match[:value], options).name
          @attributes = {}

          match[:attributes].scan(SYNTAX_ATTRIBUTES) do |key, value|
            @attributes[key.to_sym] = ::Liquid::Expression.parse(value)
          end
        end

        def render(context)
          environments = context.environments.first
          site = environments["site"]

          val = load_collection(site)

          context.scopes.last[key] = val
          context.resource_limits.assign_score += assign_score_of(val)

          ""
        end

        def blank?
          true
        end

        protected

        attr_reader :attributes, :key, :value

        def load_collection(site)
          items = load_collection_for(site, value)

          items.each_with_object([]) do |item, collection|
            collection <<
              default_values(item).reverse_merge(item.fetch("value"))
          end
        end

        def load_collection_for(site, slug)
          collection = site.collections.find_by!(slug: slug)

          site.entries
              .where(collection: collection)
              .limit(attributes.fetch(:limit, nil))
              .offset(attributes.fetch(:offset, nil))
              .map(&:attributes)
        rescue StandardError
          []
        end

        def assign_score_of(val)
          return val.length if val.instance_of?(String)

          return 1 unless val.instance_of?(Array) || val.instance_of?(Hash)

          val.inject(1) { |sum, item| sum + assign_score_of(item) }
        end

        def default_values(entry)
          {
            id: entry.fetch("id"),
            available_at: entry.fetch("available_at")
          }.deep_stringify_keys
        end
      end
    end
  end
end

::Liquid::Template.register_tag("collection",
                                Archangel::Liquid::Tags::CollectionTag)
