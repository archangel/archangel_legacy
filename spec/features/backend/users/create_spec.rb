# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Users (HTML)", type: :feature do
  def fill_in_user_form_with(name = "", username = "", email = "")
    fill_in "Name", with: name
    fill_in "Username", with: username
    fill_in "Email", with: email
  end

  describe "creation" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, username: "gabriel", email: "g@email.com") }

    describe "successful" do
      it "displays success message" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "amazing", "me@example.com")
        click_button "Create User"

        expect(page).to have_content("User was successfully created.")
      end

      it "with Role it displays success message" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "amazing", "me@example.com")
        select "Admin", from: "Role"
        click_button "Create User"

        expect(page).to have_content("User was successfully created.")
      end
    end

    describe "unsuccessful" do
      it "fails without name" do
        visit "/backend/users/new"

        fill_in_user_form_with("", "amazing", "me@example.com")
        click_button "Create User"

        expect(page.find(".form-group.user_name"))
          .to have_content("Name can't be blank")
      end

      it "fails without username" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "", "me@example.com")
        click_button "Create User"

        expect(page.find(".form-group.user_username"))
          .to have_content("Username can't be blank")
      end

      it "fails with used username" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "gabriel", "me@example.com")
        click_button "Create User"

        expect(page.find(".form-group.user_username"))
          .to have_content("Username has already been taken")
      end

      it "fails without email" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "amazing", "")
        click_button "Create User"

        expect(page.find(".form-group.user_email"))
          .to have_content("Email can't be blank")
      end

      it "fails with used emaill" do
        visit "/backend/users/new"

        fill_in_user_form_with("Amazing User", "amazing", "g@email.com")
        click_button "Create User"

        expect(page.find(".form-group.user_email"))
          .to have_content("Email has already been taken")
      end
    end
  end
end
