# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Widgets (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    describe "successful" do
      scenario "with valid data" do
        visit "/backend/widgets/new"

        fill_in "Name", with: "Amazing Widget"
        fill_in "Slug", with: "amazing"
        fill_in "Content", with: "<p>Content of the widget</p>"

        click_button "Create Widget"

        expect(page).to have_content("Widget was successfully created.")
      end

      scenario "with valid data with Design" do
        create(:design, name: "My Full Design")
        create(:design, :partial, name: "My Partial Design")

        visit "/backend/widgets/new"

        expect(page).to have_select "Design", options: ["Select design",
                                                        "My Partial Design"]

        fill_in "Name", with: "Amazing"
        fill_in "Slug", with: "amazing"
        select "My Partial Design", from: "Design"
        fill_in "Content", with: "<p>Content of the widget</p>"

        click_button "Create Widget"

        expect(page).to have_content("Widget was successfully created.")
      end
    end

    describe "unsuccessful" do
      scenario "without name" do
        visit "/backend/widgets/new"

        fill_in "Name", with: ""
        fill_in "Slug", with: "amazing"
        fill_in "Content", with: "<p>Content of the widget</p>"

        click_button "Create Widget"

        expect(page.find(".input.widget_name"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Widget was successfully created.")
      end

      scenario "without slug" do
        visit "/backend/widgets/new"

        fill_in "Name", with: "Amazing"
        fill_in "Slug", with: ""
        fill_in "Content", with: "<p>Content of the widget</p>"

        click_button "Create Widget"

        expect(page.find(".input.widget_slug"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Widget was successfully created.")
      end

      scenario "with used slug" do
        create(:widget, slug: "amazing")

        visit "/backend/widgets/new"

        fill_in "Name", with: "Amazing"
        fill_in "Slug", with: "amazing"
        fill_in "Content", with: "<p>Content of the widget</p>"

        click_button "Create Widget"

        within(".widget_slug") do
          expect(page).to have_content("has already been taken")
        end

        expect(page).not_to have_content("Widget was successfully created.")
      end

      scenario "without content" do
        visit "/backend/widgets/new"

        fill_in "Name", with: "Amazing"
        fill_in "Slug", with: "amazing"
        fill_in "Content", with: ""

        click_button "Create Widget"

        expect(page.find(".input.widget_content"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("Widget was successfully created.")
      end

      scenario "with invalid Liquid data in Content" do
        visit "/backend/widgets/new"

        fill_in "Name", with: "Amazing Widget"
        fill_in "Slug", with: "amazing"
        fill_in "Content", with: "{% widget %}"

        click_button "Create Widget"

        expect(page.find(".input.widget_content"))
          .to have_content("contains invalid Liquid formatting")

        expect(page).not_to have_content("Widget was successfully created.")
      end
    end
  end
end
