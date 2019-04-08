# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Meta tag", type: :feature do
  describe "site metatags" do
    let(:site) { create(:site) }

    before do
      create(:metatag, metatagable: site,
                       name: "description",
                       content: "Site description")
      create(:metatag, metatagable: site,
                       name: "author",
                       content: "Archangel")
    end

    it "contains default meta tags" do
      resource = create(:page, site: site)

      visit archangel.frontend_page_path(resource.permalink)

      canonical = "http://www.example.com/#{resource.permalink}"

      expect(page).to(
        have_css(
          "link[rel='canonical'][href='#{canonical}']", visible: false
        )
      )
    end

    it "contains Site meta tags" do
      resource = create(:page, site: site)

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_meta(:description, "Site description")
      expect(page).to have_meta(:author, "Archangel")

      expect(page).to have_title("#{resource.title} | #{site.name}")
    end

    it "contains Site and Page meta tags" do
      resource = create(:page, site: site)
      create(:metatag, metatagable: resource,
                       name: "description",
                       content: "Page description")
      create(:metatag, metatagable: resource,
                       name: "keywords",
                       content: "useful,page,keywords")

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_meta(:description, "Page description")
      expect(page).to have_meta(:keywords, "useful,page,keywords")
      expect(page).to have_meta(:author, "Archangel")

      expect(page).to have_title("#{resource.title} | #{site.name}")
    end

    it "always uses page.title for title (doesn't allow metatag overwrite)" do
      resource = create(:page, site: site)
      create(:metatag, metatagable: resource,
                       name: "title",
                       content: "Metatag Page Title")

      visit archangel.frontend_page_path(resource.permalink)

      expect(page).to have_title("#{resource.title} | #{site.name}")
      expect(page).to_not have_title("Metatag Page Title | #{site.name}")
    end
  end
end
