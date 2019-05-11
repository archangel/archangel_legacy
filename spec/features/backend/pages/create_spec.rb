# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Pages (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data" do
        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      scenario "with valid data with Parent" do
        create(:page, slug: "amazing", title: "Amazing")

        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Grace"
        fill_in "Slug", with: "grace"
        select "Amazing", from: "Parent"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
        expect(page).to have_content("/amazing/grace")
      end

      scenario "with valid data with Design" do
        create(:design, name: "My Design")

        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"
        select "My Design", from: "Design"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end

      scenario "with duplicate slug at different levels" do
        create(:page, slug: "amazing", title: "Amazing")
        create(:page, slug: "grace")

        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "grace"
        select "Amazing", from: "Parent"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page).to have_content("Page was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without title" do
        visit "/backend/pages/new"

        fill_in "Title", with: ""
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page.find(".input.page_title")).to have_content("can't be blank")

        expect(page).to_not have_content("Page was successfully created.")
      end

      scenario "without slug" do
        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: ""

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page.find(".input.page_slug")).to have_content("can't be blank")

        expect(page).to_not have_content("Page was successfully created.")
      end

      scenario "with used slug as same level" do
        create(:page, slug: "amazing")

        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("<p>Content of the page</p>")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        within(".page_slug") do
          expect(page).to have_content("has already been taken")
        end

        expect(page).to_not have_content("Page was successfully created.")
      end

      %w[account backend].each do |reserved_path|
        scenario "with reserved slug of `#{reserved_path}`" do
          visit "/backend/pages/new"

          fill_in "Title", with: "Reserved Page"
          fill_in "Slug", with: reserved_path

          page.find("textarea#page_content").set("<p>Content of the page</p>")

          fill_in "Published At", with: Time.now

          click_button "Create Page"

          within(".page_slug") do
            expect(page).to have_content("contains restricted path")
          end

          expect(page).to_not have_content("Page was successfully created.")
        end
      end

      scenario "without content" do
        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page.find(".input.page_content"))
          .to have_content("can't be blank")

        expect(page).to_not have_content("Page was successfully created.")
      end

      scenario "with invalid Liquid data in Content" do
        visit "/backend/pages/new"

        fill_in "Title", with: "Amazing Page"
        fill_in "Slug", with: "amazing"

        page.find("textarea#page_content").set("{% widget %}")

        fill_in "Published At", with: Time.now

        click_button "Create Page"

        expect(page.find(".input.page_content"))
          .to have_content("contains invalid Liquid formatting")

        expect(page).to_not have_content("Page was successfully created.")
      end
    end
  end
end
