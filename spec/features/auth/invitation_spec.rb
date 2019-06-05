# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth invitation", type: :feature do
  let!(:site) { create(:site) }

  describe "without invitation token" do
    it "throws an error message and redirects to the login page" do
      visit "/account/invitation/accept"

      expect(page)
        .to have_content("The invitation token provided is not valid!")
      expect(current_path).to eq("/account/login")
    end
  end

  describe "with invalid invitation token" do
    it "throws an error message and redirects to the login page" do
      visit "/account/invitation/accept?invitation_token=invalid-invite-token"

      expect(page)
        .to have_content("The invitation token provided is not valid!")
      expect(current_path).to eq("/account/login")
    end
  end

  describe "with valid invitation token" do
    let!(:invitee) do
      Archangel::User.invite!(site: site,
                              name: "Amazing",
                              username: "amazing",
                              email: "amazing@email.com",
                              role: "editor")
    end
    let!(:homepage) do
      create(:page, :homepage, content: "Welcome to the homepage")
    end

    let(:raw_token) { invitee.raw_invitation_token }

    it "has additional form fields" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_text "Name"
      expect(page).to have_text "Username"

      expect(page).to have_selector("input[type=text][id='user_name']")
      expect(page).to have_selector("input[type=text][id='user_username']")
    end

    it "allows successful registration" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_field("Name", with: "Amazing")
      expect(page).to have_field("Username", with: "amazing")

      fill_in "Password", with: "password", match: :prefer_exact
      fill_in "Confirm Password", with: "password", match: :prefer_exact

      click_button "Set my password"

      expect(page).to have_content("Welcome to the homepage")
    end
  end
end
