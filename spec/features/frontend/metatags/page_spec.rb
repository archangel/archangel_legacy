# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Meta tag", type: :feature do
  describe "Page metatags" do
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
      resource = create(:page, site: site, slug: "foo", title: "Page A")

      create(:metatag, metatagable: resource,
                       name: "description",
                       content: "Page description")
      create(:metatag, metatagable: resource,
                       name: "keywords",
                       content: "useful,page,keywords")

      visit "/foo"

      expect(page).to have_meta(:description, "Page description")
      expect(page).to have_meta(:keywords, "useful,page,keywords")
      expect(page).to have_meta(:author, "Archangel")

      expect(page).to have_title("Page A | Site A")

      expect(page).not_to have_meta(:description, "Site description")
    end
  end
end
