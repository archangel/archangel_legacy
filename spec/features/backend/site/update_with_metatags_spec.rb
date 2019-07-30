# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site (HTML)", type: :feature do
  def fill_in_metatag_form_with(index = 1, name = "", content = "")
    click_link "Add Meta Tag"

    within ".form-group.site_metatags .nested-fields:nth-of-type(#{index})" do
      first(".select2-container", minimum: 1).click
    end

    find(".select2-dropdown input.select2-search__field")
      .send_keys(name, :enter)

    within ".form-group.site_metatags .nested-fields:nth-of-type(#{index})" do
      find(:css, "input[id^='site_metatags_attributes_'][id$='_content']")
        .set(content)
    end
  end

  describe "updating with meta tags" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, :admin) }

    context "with valid data, including meta tags", js: true do
      it "updates the Site successfully with one meta tag" do
        visit "/backend/site/edit"

        fill_in_metatag_form_with(1, "description", "Description of the Site")
        click_button "Update Site"

        expect(page).to have_content("Site was successfully updated.")
      end

      it "updates the Site successfully with multiple meta tags" do
        visit "/backend/site/edit"

        fill_in_metatag_form_with(1, "description", "Description of the Site")
        fill_in_metatag_form_with(2, "keywords", "keywords, of, the, Site")
        click_button "Update Site"

        expect(page).to have_content("Site was successfully updated.")
      end
    end
  end
end
