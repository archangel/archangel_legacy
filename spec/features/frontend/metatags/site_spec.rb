# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Meta tag", type: :feature do
  describe "Site metatags" do
    let!(:site) { create(:site, name: "Site A") }

    before do
      create(:metatag, metatagable: site,
                       name: "description",
                       content: "Site description")
      create(:metatag, metatagable: site,
                       name: "author",
                       content: "Archangel")
    end

    it "contains Site meta tags" do
      create(:page, site: site, slug: "foo", title: "Page A")

      visit "/foo"

      expect(page).to have_meta(:description, "Site description")
      expect(page).to have_meta(:author, "Archangel")

      expect(page).to have_title("Page A | Site A")
    end
  end
end
