# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - User (HTML)", type: :feature do
  describe "show" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user, username: "gabriel") }

    describe "trying to edit my own profile (current_user)" do
      it "returns with 404 status" do
        visit "/backend/users/gabriel"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end

    describe "with available User" do
      it "knows the correct Name" do
        create(:user, username: "amazing", name: "Amazing User")

        visit "/backend/users/amazing"

        expect(page).to have_content("Name: Amazing User")
      end

      it "knows the correct Username" do
        create(:user, username: "amazing")

        visit "/backend/users/amazing"

        expect(page).to have_content("Username: amazing")
      end

      it "knows the correct Email" do
        create(:user, username: "amazing", email: "amazing@example.com")

        visit "/backend/users/amazing"

        expect(page).to have_content("Email: amazing@example.com")
      end

      it "uses the default Avatar" do
        create(:user, username: "amazing")

        visit "/backend/users/amazing"

        expect(page)
          .to have_css("img[src^='/assets/archangel/fallback/small_avatar']")
      end

      it "has an uploaded Avatar" do
        create(:user, :avatar, username: "amazing")

        visit "/backend/users/amazing"

        expect(page).to have_css("img[src^='/uploads/archangel/user/avatar']")
      end
    end

    describe "with unavailable User" do
      it "returns a 404 when User does not exist" do
        visit "/backend/users/unknown"

        expect(page.status_code).to eq 404
      end

      it "returns an error when User does not exist" do
        visit "/backend/users/unknown"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end

      it "returns a 404 when User is deleted" do
        create(:user, :deleted, username: "deleted", name: "Deleted User Name")

        visit "/backend/users/deleted"

        expect(page.status_code).to eq 404
      end

      it "returns an error when User is deleted" do
        create(:user, :deleted, username: "deleted", name: "Deleted User Name")

        visit "/backend/users/deleted"

        expect(page)
          .to have_content("Page not found. Could not find what was requested")
      end
    end
  end
end
