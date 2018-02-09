# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Liquid
    module Tags
      RSpec.describe CollectionTag, type: :tag,
                                    disable: :verify_partial_doubles do
        let(:site) { create(:site) }

        let(:context) do
          ::Liquid::Context.new({ "site" => site }, {}, view: view)
        end

        it "returns nothing to the view" do
          content = "{% collection things %}"

          expect { ::Liquid::Template.parse(content).render(context) }.to(
            raise_error(SyntaxError, Archangel.t("errors.syntax.collection"))
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
          create(:entry, collection: collection,
                         value: { name: "First Person" })
          create(:entry, collection: collection,
                         value: { name: "Second Person" })

          content = <<-LIQUID
            {% collection things = 'my-collection' %}
            {% for item in things %}
              {{ forloop.index }}: {{ item.name }}
            {% endfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to include("1: Second Person")
          expect(result).to include("2: First Person")
        end

        it "returns nothing for empty collection" do
          collection = create(:collection, site: site, slug: "my-collection")
          create(:field, :required, collection: collection, slug: "name")

          content = <<-LIQUID
            {% collection things = 'my-collection' %}
            {% for item in things %}
              {{ item.name }}
            {% endfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("            \n            \n")
        end

        it "returns nothing for unknown collection" do
          content = <<-LIQUID
            {% collection things = 'unknown-collection' %}
            {% for item in things %}
              {{ item.name }}
            {% endfor %}
          LIQUID

          result = ::Liquid::Template.parse(content).render(context)

          expect(result).to eq("            \n            \n")
        end
      end
    end
  end
end
