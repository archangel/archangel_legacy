# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Meta tag", type: :feature do
  describe "default metatags" do
    let(:site) { create(:site, name: "Site A") }

    let(:canonical_data) do
      "link[rel='canonical'][href='http://www.example.com/amazing']"
    end

    it "contains canonical meta tag" do
      create(:page, site: site, slug: "amazing")

      visit "/amazing"

      expect(page).to have_css(canonical_data, visible: false)
    end

    it "contains default title format (e.g. Page Name | Site Name)" do
      create(:page, site: site, slug: "amazing", title: "Page A")

      visit "/amazing"

      expect(page).to have_title("Page A | Site A")
    end

    it "always uses Page.title for title (doesn't allow metatag overwrite)" do
      resource = create(:page, site: site, slug: "amazing", title: "Page A")
      create(:metatag, metatagable: resource,
                       name: "title", content: "Attempted Page Title")

      visit "/amazing"

      expect(page).to have_title("Page A | Site A")
    end

    it "does not use custom meta tag title (doesn't allow metatag overwrite)" do
      resource = create(:page, site: site, slug: "amazing", title: "Page A")
      create(:metatag, metatagable: resource,
                       name: "title", content: "Attempted Page Title")

      visit "/amazing"

      expect(page).not_to have_title("Attempted Page Title | Site A")
    end
  end
end
