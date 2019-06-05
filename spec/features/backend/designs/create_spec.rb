# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data for a full design" do
        visit "/backend/designs/new"

        fill_in "Name", with: "Amazing Design"
        fill_in "Content", with: "<header>HEADER</header>
                                    <main>{{ content_for_layout }}</main>
                                  <footer>HEADER</footer>"
        uncheck "Partial"

        click_button "Create Design"

        expect(page).to have_content("Design was successfully created.")
      end

      scenario "with valid data for a partial design" do
        visit "/backend/designs/new"

        fill_in "Name", with: "Amazing Design"
        fill_in "Content", with: "<header>HEADER</header>
                                    <main>{{ content_for_layout }}</main>
                                  <footer>HEADER</footer>"
        check "Partial"

        click_button "Create Design"

        expect(page).to have_content("Design was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without name" do
        visit "/backend/designs/new"

        fill_in "Name", with: ""
        fill_in "Content", with: "<header>HEADER</header>
                                    <main>{{ content_for_layout }}</main>
                                  <footer>HEADER</footer>"

        click_button "Create Design"

        expect(page.find(".input.design_name"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Design was successfully created.")
      end

      scenario "without content" do
        visit "/backend/designs/new"

        fill_in "Name", with: "Amazing Design"
        fill_in "Content", with: ""

        click_button "Create Design"

        expect(page.find(".input.design_content"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Design was successfully created.")
      end

      scenario "with invalid Liquid data in Content" do
        visit "/backend/designs/new"

        fill_in "Name", with: "Amazing Design"
        fill_in "Content", with: "<header>HEADER</header>
                                    <main>{{ content_for_layout }}</main>
                                    <aside>{% widget %}</aside>
                                  <footer>HEADER</footer>"

        click_button "Create Design"

        expect(page.find(".input.design_content"))
          .to have_content("contains invalid Liquid formatting")

        expect(page).not_to have_content("Design was successfully created.")
      end
    end
  end
end
