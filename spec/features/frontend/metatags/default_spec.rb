# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Meta tag", type: :feature do
  describe "default metatags" do
    let!(:site) { create(:site, name: "Site A") }

    it "contains canonical meta tags" do
      create(:page, site: site, slug: "foo")

      visit "/foo"

      expect(page).to(
        have_css("link[rel='canonical'][href='http://www.example.com/foo']",
                 visible: false)
      )
    end

    it "contains default title format" do
      create(:page, site: site, slug: "foo", title: "Page A")

      visit "/foo"

      expect(page).to have_title("Page A | Site A")
      expect(page).to(
        have_css("link[rel='canonical'][href='http://www.example.com/foo']",
                 visible: false)
      )
    end

    it "always uses Page.title for title (doesn't allow metatag overwrite)" do
      resource = create(:page, site: site, slug: "foo", title: "Page A")
      create(:metatag, metatagable: resource,
                       name: "title",
                       content: "Attempted Page Title")

      visit "/foo"

      expect(page).to have_title("Page A | Site A")
      expect(page).not_to have_title("Attempted Page Title | Site A")
    end
  end
end
