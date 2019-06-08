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

  describe "creation" do
    before { stub_authorization! }

    describe "successful" do
      it "is displays success message with valid data" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      it "is displays success message with valid data with Parent" do
        create(:page, slug: "amazing", title: "Amazing")

        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        select "Amazing", from: "Parent"
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      it "is displays success message with valid data with Design" do
        create(:design, name: "My Design")

        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        select "My Design", from: "Design"
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      it "is successful with duplicate slug at different levels" do
        create(:page, slug: "amazing", title: "Amazing")
        create(:page, slug: "grace")

        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        select "Amazing", from: "Parent"
        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end
    end

    describe "unsuccessful" do
      it "fails with invalid published_at date" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing",
                               "<p>Amazing content</p>", "In the beginning")
        click_button "Create Page"

        expect(page.find(".input.page_published_at"))
          .to have_content("is not a date")
      end

      it "fails without title" do
        visit "/backend/pages/new"

        fill_in_page_form_with("", "amazing", "<p>Content of the page</p>")
        click_button "Create Page"

        expect(page.find(".input.page_title")).to have_content("can't be blank")
      end

      it "fails without slug" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "", "<p>Amazing content</p>")
        click_button "Create Page"

        expect(page.find(".input.page_slug")).to have_content("can't be blank")
      end

      it "fails ith used slug as same level" do
        create(:page, slug: "amazing")

        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "<p>Amazing content</p>")
        click_button "Create Page"

        expect(page.find(".input.page_slug"))
          .to have_content("has already been taken")
      end

      %w[account backend].each do |reserved_path|
        it "fails with reserved slug of `#{reserved_path}`" do
          visit "/backend/pages/new"

          fill_in_page_form_with("Amazing", reserved_path,
                                 "<p>Amazing content</p>")
          click_button "Create Page"

          expect(page.find(".input.page_slug"))
            .to have_content("contains restricted path")
        end
      end

      it "fails without content" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "")
        click_button "Create Page"

        expect(page.find(".input.page_content"))
          .to have_content("can't be blank")
      end

      it "fails with invalid Liquid data in Content" do
        visit "/backend/pages/new"

        fill_in_page_form_with("Amazing", "amazing", "{% widget %}")

        click_button "Create Page"

        expect(page.find(".input.page_content"))
          .to have_content("contains invalid Liquid formatting")
      end
    end
  end
end
