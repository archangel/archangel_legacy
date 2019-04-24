# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Liquid custom filters", type: :feature do
  let!(:site) { create(:site) }

  describe "for `link_to` filter" do
    it "builds linked text with URL" do
      content = "{{ 'Hello world' | link_to: 'https://github.com' }}"

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_link("Hello world", href: "https://github.com")
    end

    it "builds linked text with path" do
      content = "{{ 'Hello world' | link_to: '/some/place' }}"

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_link("Hello world", href: "/some/place")
    end

    it "builds text with blank link value" do
      content = "{{ 'Hello world' | link_to: '' }}"

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_text("Hello world")
      expect(page).to_not have_link("Hello world", href: "https://github.com")
    end

    it "builds text with null link value" do
      content = "{{ 'Hello world' | link_to: null }}"

      create(:page, site: site, slug: "foo", content: content)

      visit "/foo"

      expect(page).to have_text("Hello world")
      expect(page).to_not have_link("Hello world", href: "https://github.com")
    end
  end
end
