# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe CollectionforTag, type: :liquid_tag do
        let(:site) { create(:site) }

        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = <<-LIQUID
            {% collectionfor item as 'my-collection' %}
              {{ forloop.index }}: {{ item.name }}
            {% endcollectionfor %}
          LIQUID

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns nothing to the view" do
          create(:collection, site: site, slug: "my-collection")

          content = <<-LIQUID
            {%- collectionfor item in 'my-collection' -%}
              {{ forloop.index }}: {{ item.name }}
            {%- endcollectionfor -%}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end

        it "returns collection content" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")
          create(:entry, collection: collection, value: { name: "First" })
          create(:entry, collection: collection, value: { name: "Second" })
          create(:entry, collection: collection, value: { name: "Third" })

          content = <<-LIQUID
            {% collectionfor item in 'my-collection' %}
              {{ forloop.index }}: {{ item.name }}
            {% endcollectionfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: Third")
          expect(result).to include("2: Second")
          expect(result).to include("3: First")
        end

        it "returns collection content with limit and offset" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")
          create(:entry, collection: collection, value: { name: "First" })
          create(:entry, collection: collection, value: { name: "Second" })
          create(:entry, collection: collection, value: { name: "Third" })

          content = <<-LIQUID
            {% collectionfor item in 'my-collection' limit:1 offset:2 %}
              {{ forloop.index }}: {{ item.name }}
            {% endcollectionfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: Second")

          expect(result).not_to include("First")
          expect(result).not_to include("Third")
        end

        it "returns reversed collection content" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")
          create(:entry, collection: collection, value: { name: "First" })
          create(:entry, collection: collection, value: { name: "Second" })
          create(:entry, collection: collection, value: { name: "Third" })

          content = <<-LIQUID
            {% collectionfor item in 'my-collection' reversed %}
              {{ forloop.index }}: {{ item.name }}
            {% endcollectionfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: First")
          expect(result).to include("2: Second")
          expect(result).to include("3: Third")
        end

        it "returns nothing for unknown collection" do
          content = <<-LIQUID
            {%- collectionfor item in 'unknown-collection' -%}
              {{ forloop.index }}: {{ item.name }}
            {%- endcollectionfor -%}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
