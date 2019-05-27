# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe CollectionTag, type: :liquid_tag do
        let(:site) { create(:site) }
        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "raises error with invalid syntax" do
          content = "{% collection things %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(::Liquid::SyntaxError)
          )
        end

        it "returns nothing to the view" do
          create(:collection, site: site, slug: "my-collection")

          content = "{% collection things = 'my-collection' %}"

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end

        it "returns collection content" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")
          create(:entry, collection: collection, value: { name: "First" })
          create(:entry, collection: collection, value: { name: "Second" })

          content = <<-LIQUID
            {% collection things = 'my-collection' %}
            {% for item in things %}
              {{ forloop.index }}: {{ item.name }}
            {% endfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: Second")
          expect(result).to include("2: First")
        end

        it "returns collection content with limit and offset" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")
          create(:entry, collection: collection, value: { name: "First" })
          create(:entry, collection: collection, value: { name: "Second" })
          create(:entry, collection: collection, value: { name: "Third" })

          content = <<-LIQUID
            {% collection things = 'my-collection' limit:1 offset:2 %}
            {% for item in things %}
              {{ forloop.index }}: {{ item.name }}
            {% endfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: Second")

          expect(result).not_to include("First")
          expect(result).not_to include("Third")
        end

        it "returns nothing for empty collection" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")

          content = <<-LIQUID
            {%- collection things = 'my-collection' -%}
            {%- for item in things -%}
              {{ item.name }}
            {%- endfor -%}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end

        it "returns nothing for unknown collection" do
          content = <<-LIQUID
            {%- collection things = 'unknown-collection' -%}
            {%- for item in things -%}
              {{ item.name }}
            {%- endfor -%}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("")
        end
      end
    end
  end
end
