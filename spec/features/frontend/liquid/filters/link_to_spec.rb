# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom filters", type: :feature do
  describe "for `link_to` filter" do
    it "builds linked text with URL" do
      content = "{{ 'Hello world' | link_to: 'https://github.com' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_link("Hello world", href: "https://github.com")
    end

    it "builds linked text with path" do
      content = "{{ 'Hello world' | link_to: '/some/place' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_link("Hello world", href: "/some/place")
    end

    it "returns plain text with blank link value" do
      content = "{{ 'Hello world' | link_to: '' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_text("Hello world")
    end

    it "returns plain text without a link with blank link value" do
      content = "{{ 'Hello world' | link_to: '' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).not_to have_link("Hello world", href: "https://github.com")
    end

    it "returns plain text with `null` link value" do
      content = "{{ 'Hello world' | link_to: null }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_text("Hello world")
    end

    it "returns plain text without a link with `null` link value" do
      content = "{{ 'Hello world' | link_to: null }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).not_to have_link("Hello world", href: "https://github.com")
    end
  end
end
