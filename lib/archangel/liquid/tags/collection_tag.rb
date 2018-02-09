# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Assign sets a variable in your template.
      #
      #   {% collection foo = 'my-collection' %}
      #
      # You can then use the variable later in the page.
      #
      #  {{ foo }}
      #
      class CollectionTag < ::Liquid::Tag
        SYNTAX = /(#{::Liquid::VariableSignature}+)\s*=\s*(.*)\s*/om

        def initialize(tag_name, markup, options)
          super

          if markup =~ SYNTAX
            collection_name = ::Liquid::Variable.new($2, options).name

            @to = $1
            @from = override_collection(collection_name)
          else
            raise SyntaxError.new options[:locale].t("errors.syntax.assign")
          end
        end

        def render(context)
          val = @from

          context.scopes.last[@to] = val
          context.resource_limits.assign_score += assign_score_of(val)

          ""
        end

        def blank?
          true
        end

        private

        def override_collection(collection_slug)
          items = load_collection_for(Archangel::Site.first, collection_slug)

          items.each_with_object([]) do |item, collection|
            collection << {
              "id"           => item["id"],
              "available_at" => item["available_at"]
            }.reverse_merge(item["value"])
          end
        end

        def load_collection_for(site, collection_slug)
          collection = site.collections.find_by!(slug: collection_slug)

          site.entries.where(collection: collection).map(&:attributes)
        rescue StandardError
          []
        end

        def assign_score_of(val)
          if val.instance_of?(String)
            val.length
          elsif val.instance_of?(Array) || val.instance_of?(Hash)
            val.inject(1) { |sum, i| sum + assign_score_of(i) }
          else
            1
          end
        end
      end
    end
  end
end

::Liquid::Template.register_tag("collection",
                                Archangel::Liquid::Tags::CollectionTag)
