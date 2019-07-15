# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs (HTML)", type: :feature do
  def fill_in_design_form_with(name = "", content = "")
    fill_in "Name", with: name
    fill_in "Content", with: content
  end

  describe "creation" do
    before { stub_authorization! }

    let(:design_content) do
      %(
        <header>HEADER</header>
        <main>{{ content_for_layout }}</main>
        <footer>HEADER</footer>
      )
    end

    describe "with valid data" do
      it "is successful not as a Partial" do
        visit "/backend/designs/new"

        fill_in_design_form_with("Amazing Design", design_content)
        uncheck "Partial"
        click_button "Create Design"

        expect(page).to have_content("Design was successfully created.")
      end

      it "is successful as a Partial" do
        visit "/backend/designs/new"

        fill_in_design_form_with("Amazing Design", design_content)
        check "Partial"
        click_button "Create Design"

        expect(page).to have_content("Design was successfully created.")
      end
    end

    describe "with invalid data" do
      it "fails without name" do
        visit "/backend/designs/new"

        fill_in_design_form_with("", design_content)
        click_button "Create Design"

        expect(page.find(".form-group.design_name"))
          .to have_content("Name can't be blank")
      end

      it "fails without content" do
        visit "/backend/designs/new"

        fill_in_design_form_with("Amazing Design", "")
        click_button "Create Design"

        expect(page.find(".form-group.design_content"))
          .to have_content("Content can't be blank")
      end

      it "fails with invalid Liquid data in Content" do
        visit "/backend/designs/new"

        fill_in_design_form_with("Amazing Design", "<div>{% widget %}</div>")
        click_button "Create Design"

        expect(page.find(".form-group.design_content"))
          .to have_content("Content contains invalid Liquid formatting")
      end
    end
  end
end
