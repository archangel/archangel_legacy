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
      class CollectionTag < ApplicationTag
        ##
        # {% collection key = 'value' %}
        #
        SYNTAX = /
          (?<key>#{::Liquid::VariableSignature}+)
          \s*
          =
          \s*
          (?<value>.*)
          \s*
        /omx

        def initialize(tag_name, markup, options)
          super

          match = SYNTAX.match(markup)

          if match.blank?
            raise SyntaxError, Archangel.t("errors.syntax.collection")
          end

          @key = match[:key]
          @value = ::Liquid::Variable.new(match[:value], options).name
        end

        def render(context)
          val = load_collection(value)

          context.scopes.last[key] = val
          context.resource_limits.assign_score += assign_score_of(val)

          ""
        end

        def blank?
          true
        end

        protected

        attr_reader :key, :value

        def load_collection(slug)
          items = load_collection_for(Archangel::Site.first, slug)

          items.each_with_object([]) do |item, collection|
            collection <<
              default_values(item).reverse_merge(item.fetch("value"))
          end
        end

        def load_collection_for(site, slug)
          collection = site.collections.find_by!(slug: slug)

          site.entries.where(collection: collection).map(&:attributes)
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
