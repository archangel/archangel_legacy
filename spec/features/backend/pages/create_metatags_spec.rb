# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  def fill_in_page_form_with(title = "", slug = "", content = "",
                             published_at = Time.now)
    fill_in "Title", with: title
    fill_in "Slug", with: slug
    page.find("textarea#page_content").set(content)
    fill_in "Published At", with: published_at
  end

  def fill_in_metatag_form_with(name = "", content = "")
    fill_in "Name", with: name
    fill_in "Content", with: content
  end

  describe "creation" do
    before { stub_authorization! }

    describe "successful" do
      it "displays success message even with meta tag data" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")

        within ".form-group.page_metatags" do
          fill_in_metatag_form_with("description", "Description of the Page")
        end

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end
    end
  end
end
