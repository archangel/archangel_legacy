# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Auth invitation", type: :feature do
  let(:site) { create(:site) }

  describe "with invalid invitation token" do
    it "throws an error message with invalid invitation_token query param" do
      visit "/account/invitation/accept?invitation_token=invalid-invite-token"

      expect(page)
        .to have_content("The invitation token provided is not valid!")
    end

    it "throws an error message without invitation_token query param" do
      visit "/account/invitation/accept"

      expect(page)
        .to have_content("The invitation token provided is not valid!")
    end

    it "redirects to the login page" do
      visit "/account/invitation/accept"

      expect(page).to have_current_path("/account/login")
    end
  end

  describe "with valid invitation token" do
    let(:invitee) do
      Archangel::User.invite!(site: site,
                              name: "Amazing",
                              username: "amazing",
                              email: "amazing@email.com",
                              role: "editor")
    end

    let(:raw_token) { invitee.raw_invitation_token }

    before do
      invitee

      create(:page, :homepage, content: "Welcome to the homepage")
    end

    it "does not allow editing Role" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).not_to have_text "Role"
    end

    it "has additional Name form field label" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_text "Name"
    end

    it "has additional Username form field label" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_text "Username"
    end

    it "has additional `name` form field" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_selector("input[type=text][id='user_name']")
    end

    it "has additional `username` form field" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      expect(page).to have_selector("input[type=text][id='user_username']")
    end

    it "allows successful invitation acceptance and redirects to homepage" do
      visit "/account/invitation/accept?invitation_token=#{raw_token}"

      fill_in_invitation_form_with("password", "password")
      click_button "Set my password"

      expect(page).to have_content("Welcome to the homepage")
    end
  end
end
