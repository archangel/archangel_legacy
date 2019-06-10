# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Meta tag", type: :feature do
  describe "Page metatags" do
    let(:site) { create(:site, name: "Site A") }
    let(:resource) do
      create(:page, site: site, slug: "amazing", title: "Page A")
    end

    before do
      create(:metatag, metatagable: site,
                       name: "description",
                       content: "Site description")
      create(:metatag, metatagable: site,
                       name: "author",
                       content: "Archangel")

      create(:metatag, metatagable: resource,
                       name: "description",
                       content: "Page description")
      create(:metatag, metatagable: resource,
                       name: "keywords",
                       content: "useful,page,keywords")
    end

    it "contains Page description meta tag" do
      visit "/amazing"

      expect(page).to have_meta(:description, "Page description")
    end

    it "does not use Site description when Page description meta tag used" do
      visit "/amazing"

      expect(page).not_to have_meta(:description, "Site description")
    end

    it "contains Page keywords meta tag" do
      visit "/amazing"

      expect(page).to have_meta(:keywords, "useful,page,keywords")
    end

    it "contains Site author meta tag" do
      visit "/amazing"

      expect(page).to have_meta(:author, "Archangel")
    end

    it "contains correct Page title (e.g. Page Name | Site Name)" do
      visit "/amazing"

      expect(page).to have_title("Page A | Site A")
    end
  end
end
