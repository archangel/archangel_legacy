# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  def fill_in_page_form_with(title = "", slug = "", content = "",
                             published_at = Time.zone.now)
    fill_in "Title", with: title
    fill_in "Slug", with: slug
    fill_in "Content", with: content
    fill_in "Published At", with: published_at
  end

  def fill_in_metatag_form_with(index = 1, name = "", content = "")
    click_link "Add Meta Tag"

    within ".form-group.page_metatags .nested-fields:nth-of-type(#{index})" do
      find(:css, "input[id^='page_metatags'][id$='_content']")
        .set(content)
      first(".select2-container", minimum: 1).click
    end

    find(".select2-dropdown input.select2-search__field")
      .send_keys(name, :enter)
  end

  describe "creation with meta tags" do
    before { stub_authorization! }

    context "with valid data, including meta tags", js: true do
      it "creates the Page successfully with one meta tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        fill_in_metatag_form_with(1, "description", "Description of the Page")
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      it "creates the Page successfully with multiple meta tags" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        fill_in_metatag_form_with(1, "description", "Description of the Page")
        fill_in_metatag_form_with(2, "keywords", "keywords, of, the, page")
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end
    end
  end
end
