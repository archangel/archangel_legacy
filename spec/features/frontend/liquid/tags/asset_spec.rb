# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Liquid custom tags", type: :feature do
  describe "for `asset` tag" do
    before { create(:site) }

    it "returns content with valid Asset file_name" do
      asset = create(:asset, file_name: "amazing.jpg")
      create(:page, slug: "amazing", content: "{% asset 'amazing.jpg' %}")

      visit "/amazing"

      expect(page)
        .to have_css("img[src='#{asset.file.url}'][alt='amazing.jpg']")
    end

    it "returns link for non-image Asset" do
      asset = create(:asset, file_name: "amazing.css")
      asset.update(content_type: "text/css")

      create(:page, slug: "amazing", content: "{% asset 'amazing.css' %}")

      visit "/amazing"

      expect(page).to have_link("amazing.css", href: asset.file.url)
    end

    context "with `size` attribute" do
      %w[small tiny].each do |size|
        it "returns `#{size}` sized image Asset" do
          asset = create(:asset, file_name: "amazing.jpg")
          create(:page, slug: "amazing",
                        content: "{% asset 'amazing.jpg' size: '#{size}' %}")

          visit "/amazing"

          expect(page).to have_css("img[src='#{asset.file.send(size).url}']")
        end
      end

      it "returns original size Asset with unrecognized size" do
        asset = create(:asset, file_name: "amazing.jpg")
        create(:page, slug: "amazing",
                      content: "{% asset 'amazing.jpg' size: 'unknown' %}")

        visit "/amazing"

        expect(page).to have_css("img[src='#{asset.file.url}']")
      end
    end

    it "returns Asset with options" do
      asset = create(:asset, file_name: "amazing.jpg")
      create(:page, slug: "amazing",
                    content: "{% asset 'amazing.jpg' alt: 'Amazing' %}")

      visit "/amazing"

      expect(page).to have_css("img[src='#{asset.file.url}'][alt='Amazing']")
    end

    it "returns nothing with deleted Asset" do
      create(:asset, :deleted, file_name: "amazing.jpg")
      create(:page, slug: "amazing", content: "~{% asset 'amazing.jpg' %}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end

    it "returns nothing when Asset is not found" do
      create(:page, slug: "amazing", content: "~{% asset 'unknown.jpg' %}~")

      visit "/amazing"

      expect(page).to have_content("~~")
    end
  end
end
