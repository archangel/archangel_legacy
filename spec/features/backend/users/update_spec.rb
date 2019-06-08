# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Users (HTML)", type: :feature do
  describe "updating" do
    before { stub_authorization! }

    describe "with valid data" do
      it "returns successfully" do
        create(:user, username: "amazing")

        visit "/backend/users/amazing/edit"

        fill_in "Username", with: "grace"
        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end
    end

    describe "with invalid data" do
      before do
        create(:user, username: "amazing", email: "amazing@example.com")
        create(:user, username: "grace", email: "grace@example.com")
      end

      it "fails with used email" do
        visit "/backend/users/amazing/edit"

        fill_in "Email", with: "grace@example.com"
        click_button "Update User"

        expect(page.find(".input.user_email"))
          .to have_content("has already been taken")
      end

      it "fails with used username" do
        visit "/backend/users/amazing/edit"

        fill_in "Username", with: "grace"
        click_button "Update User"

        expect(page.find(".input.user_username"))
          .to have_content("has already been taken")
      end
    end
  end
end
