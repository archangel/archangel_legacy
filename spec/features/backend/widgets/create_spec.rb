# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets (HTML)", type: :feature do
  def fill_in_widget_form_with(name = "", slug = "", content = "")
    fill_in "Name", with: name
    fill_in "Slug", with: slug
    fill_in "Content", with: content
  end

  describe "creation" do
    before { stub_authorization! }

    describe "with Designs in select" do
      before do
        create(:design, name: "My Full Design")
        create(:design, :partial, name: "My Partial Design")
      end

      it "has only partial Designs in select" do
        visit "/backend/widgets/new"

        expect(page).to have_select "Design", options: ["Select design",
                                                        "My Partial Design"]
      end

      it "does not contain non-partial Designs in select" do
        visit "/backend/widgets/new"

        expect(page).not_to have_select "Design", options: ["Select design",
                                                            "My Full Design"]
      end

      it "is A-Z alphabetized" do
        create(:design, :partial, name: "Good Partial Design")

        visit "/backend/widgets/new"

        expect(page).to have_select "Design", options: ["Select design",
                                                        "Good Partial Design",
                                                        "My Partial Design"]
      end
    end

    describe "with valid data" do
      it "is successful" do
        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing Widget", "amazing",
                                 "<p>Content of the widget</p>")
        click_button "Create Widget"

        expect(page).to have_content("Widget was successfully created.")
      end

      it "with valid data with Design" do
        create(:design, :partial, name: "My Partial Design")

        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing Widget", "amazing",
                                 "<p>Content of the widget</p>")
        select "My Partial Design", from: "Design"
        click_button "Create Widget"

        expect(page).to have_content("Widget was successfully created.")
      end
    end

    context "with invalid data" do
      it "fails without name" do
        visit "/backend/widgets/new"

        fill_in_widget_form_with("", "amazing", "<p>Content of the widget</p>")
        click_button "Create Widget"

        expect(page.find(".input.widget_name"))
          .to have_content("can't be blank")
      end

      it "fails without slug" do
        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing", "", "<p>Content of the widget</p>")
        click_button "Create Widget"

        expect(page.find(".input.widget_slug"))
          .to have_content("can't be blank")
      end

      it "fails with used slug" do
        create(:widget, slug: "amazing")

        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing", "amazing",
                                 "<p>Content of the widget</p>")
        click_button "Create Widget"

        expect(page.find(".input.widget_slug"))
          .to have_content("has already been taken")
      end

      it "fails without content" do
        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing", "amazing", "")
        click_button "Create Widget"

        expect(page.find(".input.widget_content"))
          .to have_content("can't be blank")
      end

      it "fails with invalid Liquid data in Content" do
        visit "/backend/widgets/new"

        fill_in_widget_form_with("Amazing", "amazing", "{% widget %}")
        click_button "Create Widget"

        expect(page.find(".input.widget_content"))
          .to have_content("contains invalid Liquid formatting")
      end
    end
  end
end
