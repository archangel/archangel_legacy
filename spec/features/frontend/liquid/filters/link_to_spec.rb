# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom filters", type: :feature do
  describe "for `link_to` filter" do
    let(:repo) { "https://github.com/archangel/archangel" }

    it "returns plain text with blank link value" do
      content = "{{ 'Amazing Grace' | link_to }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_text("Amazing Grace")
    end

    it "returns plain text with empty link value" do
      content = "{{ 'Amazing Grace' | link_to: '' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_text("Amazing Grace")
    end

    it "returns linked text with a link" do
      content = "{{ 'Amazing Grace' | link_to: '#{repo}' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_link("Amazing Grace", href: repo)
    end

    it "returns linked text with a path" do
      content = "{{ 'Amazing Grace' | link_to: '/amazing/grace' }}"

      create(:page, slug: "amazing", content: content)

      visit "/amazing"

      expect(page).to have_link("Amazing Grace", href: "/amazing/grace")
    end
  end
end
