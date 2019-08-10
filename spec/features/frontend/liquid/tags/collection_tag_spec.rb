# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `collection` tag" do
    let(:content) do
      %(
        {% collection things = 'amazing' %}
        {% for item in things %}
          {{ forloop.index }}: {{ item.name }}
        {% endfor %}
      )
    end

    let(:optioned_content) do
      %(
        {% collection things = 'amazing' limit:1 offset:2 %}
        {% for item in things %}
          {{ forloop.index }}: {{ item.name }}
        {% endfor %}
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

    it "returns nothing when there is nothing in the Collection" do
      create(:collection, slug: "empty-collection")
      create(:page, slug: "amazing",
                    content: "~{% collection things = 'empty-collection' %}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end

    it "returns nothing when the Collection is deleted" do
      create(:collection, :deleted, slug: "empty-collection")
      create(:page, slug: "amazing",
                    content: "~{% collection things = 'unknown-collection' %}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end

    it "returns nothing when the Collection is not found" do
      create(:page, slug: "amazing",
                    content: "~{% collection things = 'unknown-collection' %}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end
  end
end
