# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Profile (HTML)", type: :feature do
  describe "creation" do
    before do
      create(:user, email: "gabriel@email.com", username: "gabriel")

      stub_authorization!(profile)
    end

    let(:profile) { create(:user) }

    describe "with valid data" do
      it "succeeds without password change" do
        visit "/backend/profile/edit"

        fill_in "Name", with: "Amazing User"
        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      it "succeeds with password change" do
        visit "/backend/profile/edit"

        fill_in_password_with("new password", "new password")
        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      it "succeeds with password confirmation but without password" do
        visit "/backend/profile/edit"

        fill_in_password_with("", "new password")
        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      it "succeeds with avatar change" do
        visit "/backend/profile/edit"

        attach_file "Avatar", uploader_test_image
        click_button "Update User"

        expect(page).to have_content("User was successfully updated.")
      end

      it "shows uploaded avatar" do
        visit "/backend/profile/edit"

        attach_file "Avatar", uploader_test_image
        click_button "Update User"

        expect(page).to have_css("img[src^='/uploads/archangel/user/avatar']")
      end
    end

    describe "with invalid data" do
      it "fails without name" do
        visit "/backend/profile/edit"

        fill_in "Name", with: ""
        click_button "Update User"

        expect(page.find(".form-group.profile_name"))
          .to have_content("Name can't be blank")
      end

      it "fails with non-image avatar" do
        visit "/backend/profile/edit"

        attach_file "Avatar", uploader_test_stylesheet
        click_button "Update User"

        expect(page.find(".form-group.profile_avatar"))
          .to have_content("You are not allowed to upload \"css\" files")
      end

      it "fails without username" do
        visit "/backend/profile/edit"

        fill_in "Username", with: ""
        click_button "Update User"

        expect(page.find(".form-group.profile_username"))
          .to have_content("Username can't be blank")
      end

      it "fails with already used username" do
        visit "/backend/profile/edit"

        fill_in "Username", with: "gabriel"
        click_button "Update User"

        expect(page.find(".form-group.profile_username"))
          .to have_content("Username has already been taken")
      end

      it "fails with password and password confirmation mismatch" do
        visit "/backend/profile/edit"

        fill_in_password_with("correct password", "incorrect password")
        click_button "Update User"

        expect(page.find(".form-group.profile_password_confirmation"))
          .to have_content("Confirm Password doesn't match Password")
      end

      it "fails without email" do
        visit "/backend/profile/edit"

        fill_in "Email", with: ""
        click_button "Update User"

        expect(page.find(".form-group.profile_email"))
          .to have_content("Email can't be blank")
      end

      it "fails with already used email" do
        visit "/backend/profile/edit"

        fill_in "Email", with: "gabriel@email.com"
        click_button "Update User"

        expect(page.find(".form-group.profile_email"))
          .to have_content("Email has already been taken")
      end

      it "fails when email isn't an email" do
        visit "/backend/profile/edit"

        fill_in "Email", with: "gabriel_at_email_dot_com"
        click_button "Update User"

        expect(page.find(".form-group.profile_email"))
          .to have_content("Email is invalid")
      end
    end
  end
end
