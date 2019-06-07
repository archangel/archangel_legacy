# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Meta tag", type: :feature do
  describe "Site metatags" do
    let(:site) { create(:site, name: "Site A") }

    before do
      create(:metatag, metatagable: site,
                       name: "description",
                       content: "Site description")
      create(:metatag, metatagable: site,
                       name: "author",
                       content: "Archangel")
    end

    it "contains Site description meta tag" do
      create(:page, site: site, slug: "amazing", title: "Page A")

      visit "/amazing"

      expect(page).to have_meta(:description, "Site description")
    end

    it "contains Site author meta tag" do
      create(:page, site: site, slug: "amazing", title: "Page A")

      visit "/amazing"

      expect(page).to have_meta(:author, "Archangel")
    end

    it "contains the correct Page title (e.g. Page Name | Site Name)" do
      create(:page, site: site, slug: "amazing", title: "Page A")

      visit "/amazing"

      expect(page).to have_title("Page A | Site A")
    end
  end
end
