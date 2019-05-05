# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Backend - Users (HTML)", type: :feature do
  describe "listing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    before do
      ("A".."Z").each { |letter| create(:user, name: "User #{letter} Name") }
    end

    describe "sorted" do
      scenario "ascending from A-Z (default)" do
        visit "/backend/users"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("User A Name")
          expect(page.find("tr:eq(2)")).to have_content("User B Name")
          expect(page.find("tr:eq(3)")).to have_content("User C Name")
        end
      end
    end

    describe "paginated" do
      scenario "finds the second page of Users" do
        visit "/backend/users?page=2"

        expect(page).to_not have_content("User A Name")
        expect(page).to_not have_content("User X Name")

        expect(page).to have_content("User Y Name")
        expect(page).to have_content("User Z Name")
      end

      scenario "finds the second page of Users with `per` count" do
        visit "/backend/users?page=2&per=3"

        expect(page).to_not have_content("User A Name")
        expect(page).to_not have_content("User C Name")

        expect(page).to have_content("User D Name")
        expect(page).to have_content("User F Name")

        expect(page).to_not have_content("User G Name")
        expect(page).to_not have_content("User Z Name")
      end

      scenario "finds nothing outside the count" do
        visit "/backend/users?page=2&per=26"

        expect(page).to have_content("No users found.")

        expect(page).to_not have_content("User A Name")
        expect(page).to_not have_content("User Z Name")
      end
    end

    describe "excludes" do
      scenario "deleted Users" do
        create(:user, :deleted, name: "Deleted User Name")

        visit "/backend/users"

        expect(page).to_not have_content("Deleted User Name")
      end
    end
  end
end
