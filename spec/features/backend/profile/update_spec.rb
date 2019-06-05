# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Profile (HTML)", type: :feature do
  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, name: "John Doe") }

    describe "successful" do
      scenario "with valid data for profile without password change" do
        visit "/backend/profile/edit"

        fill_in "Name", with: "Amazing User"

        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      scenario "with valid data for profile with avatar" do
        visit "/backend/profile/edit"

        fill_in "Username", with: "glory"
        attach_file "Avatar", uploader_test_image

        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")

        expect(page).to have_css("img[src^='/uploads/archangel/user/avatar']")
        expect(page).to have_css("img[alt='glory']")
      end

      scenario "with valid data for profile with password change" do
        visit "/backend/profile/edit"

        fill_in "Name", with: "Amazing User"
        page.find("input#profile_password").set("new password")
        page.find("input#profile_password_confirmation").set("new password")

        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      scenario "with password confirmation but without password" do
        visit "/backend/profile/edit"

        page.find("input#profile_password").set("")
        page.find("input#profile_password_confirmation").set("new password")

        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end
    end

    describe "unsuccessful" do
      scenario "without name" do
        visit "/backend/profile/edit"

        fill_in "Name", with: ""

        click_button "Update User"

        expect(page.find(".input.profile_name"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "with non-image" do
        visit "/backend/profile/edit"

        attach_file "Avatar", uploader_test_stylesheet

        click_button "Update User"

        message = "You are not allowed to upload \"css\" files, allowed " \
                  "types: gif, jpeg, jpg, png"

        expect(page.find(".input.profile_avatar")).to have_content(message)

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "without username" do
        visit "/backend/profile/edit"

        fill_in "Username", with: ""

        click_button "Update User"

        expect(page.find(".input.profile_username"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "with already used username" do
        create(:user, username: "gabriel")

        visit "/backend/profile/edit"

        fill_in "Username", with: "gabriel"

        click_button "Update User"

        expect(page.find(".input.profile_username"))
          .to have_content("has already been taken")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "with password and password confirmation mismatch" do
        visit "/backend/profile/edit"

        page.find("input#profile_password").set("my correct password")
        page.find("input#profile_password_confirmation")
            .set("my incorrect password")

        click_button "Update User"

        expect(page.find(".input.profile_password_confirmation"))
          .to have_content("doesn't match Password")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "without email" do
        visit "/backend/profile/edit"

        fill_in "Email", with: ""

        click_button "Update User"

        expect(page.find(".input.profile_email"))
          .to have_content("can't be blank")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "with already used email" do
        create(:user, email: "gabriel@email.com")

        visit "/backend/profile/edit"

        fill_in "Email", with: "gabriel@email.com"

        click_button "Update User"

        expect(page.find(".input.profile_email"))
          .to have_content("has already been taken")

        expect(page).not_to have_content("User was successfully updated.")
      end

      scenario "when email isn't an email" do
        visit "/backend/profile/edit"

        fill_in "Email", with: "gabriel_at_email_dot_com"

        click_button "Update User"

        expect(page.find(".input.profile_email"))
          .to have_content("is invalid")

        expect(page).not_to have_content("User was successfully updated.")
      end
    end
  end
end
