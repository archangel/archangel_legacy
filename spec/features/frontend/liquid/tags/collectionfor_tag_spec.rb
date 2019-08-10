# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `collectionfor` tag" do
    let(:content) do
      %(
        {% collectionfor item in 'amazing' %}
          {{ forloop.index }}: {{ item.name }}
        {% endcollectionfor %}
      )
    end

    let(:unknown_content) do
      %(
        {%- collectionfor item in 'unknown-collection' -%}
          {{ forloop.index }}: {{ item.name }}
        {%- endcollectionfor -%}
      )
    end

    let(:optioned_content) do
      %(
        {% collectionfor item in 'amazing' limit:1 offset:2 %}
          {{ forloop.index }}: {{ item.name }}
        {% endcollectionfor %}
      )
    end

    let(:reversed_content) do
      %(
        {% collectionfor item in 'amazing' reversed %}
          {{ forloop.index }}: {{ item.name }}
        {% endcollectionfor %}
      )
    end

    let(:break_content) do
      %(
        {%- collectionfor item in 'amazing' -%}
          {% if item.name == 'Second' %}
            {% break %}
          {% else %}
            {{ item.name }}
          {% endif %}
        {%- endcollectionfor -%}
      )
    end

    let(:continue_content) do
      %(
        {%- collectionfor item in 'amazing' -%}
          {% if item.name == 'Second' %}
            {% continue %}
          {% else %}
            {{ item.name }}
          {% endif %}
        {%- endcollectionfor -%}
      )
    end

    before do
      create(:site)

      collection = create(:collection, slug: "amazing")

      create(:field, collection: collection, slug: "name")

      create(:entry, collection: collection, value: { name: "First Item" })
      create(:entry, collection: collection, value: { name: "Second Item" })
      create(:entry, collection: collection, value: { name: "Third Item" })
    end

    it "returns Collection content" do
      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      %w[Third Second First].each.with_index(1) do |name, index|
        expect(page).to have_content("#{index}: #{name} Item")
      end
    end

    it "returns Collection content with limit and offset" do
      create(:page, slug: "amazing", content: optioned_content)

      visit "/amazing"

      expect(page).to have_content("1: Second Item")
    end

    it "does not return unused Collection content from limit and offset" do
      create(:page, slug: "amazing", content: optioned_content)

      visit "/amazing"

      %w[Third First].each do |name|
        expect(page).not_to have_content("#{name} Item")
      end
    end

    it "returns reversed Collection content" do
      create(:page, slug: "amazing", content: reversed_content)

      visit "/amazing"

      %w[First Second Third].each.with_index(1) do |name, index|
        expect(page).to have_content("#{index}: #{name} Item")
      end
    end

    it "returns Collection content with break" do
      create(:page, slug: "amazing", content: break_content)

      visit "/amazing"

      %w[Second First].each do |item|
        expect(page).to have_content("#{item} Item")
      end
    end

    it "returns Collection content with continue" do
      create(:page, slug: "amazing", content: continue_content)

      visit "/amazing"

      %w[Third First].each do |item|
        expect(page).to have_content("#{item} Item")
      end
    end

    it "returns nothing when there is nothing in the Collection" do
      create(:collection, slug: "unknown-collection")
      create(:page, slug: "amazing", content: "~#{unknown_content}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end

    it "returns nothing when the Collection is deleted" do
      create(:collection, :deleted, slug: "unknown-collection")
      create(:page, slug: "amazing", content: "~#{unknown_content}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end

    it "returns nothing when the Collection is not found" do
      create(:page, slug: "amazing", content: "~#{unknown_content}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end
  end
end
