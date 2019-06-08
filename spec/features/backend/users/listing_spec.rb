# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Users (HTML)", type: :feature do
  describe "listing" do
    before do
      stub_authorization!

      ("A".."Z").each { |letter| create(:user, name: "User #{letter} Name") }
    end

    describe "sorted ascending A-Z (default)" do
      it "displays the first resource" do
        visit "/backend/users"

        within("tbody") do
          expect(page.find("tr:eq(1)")).to have_content("User A Name")
        end
      end

      it "displays the second resource" do
        visit "/backend/users"

        within("tbody") do
          expect(page.find("tr:eq(2)")).to have_content("User B Name")
        end
      end

      it "displays the third resource" do
        visit "/backend/users"

        within("tbody") do
          expect(page.find("tr:eq(3)")).to have_content("User C Name")
        end
      end
    end

    describe "paginated" do
      it "finds the second page of Users" do
        visit "/backend/users?page=2"

        expect(page).to have_content("User Y Name")
      end

      it "finds the second page of Users with `per` count" do
        visit "/backend/users?page=2&per=3"

        expect(page).to have_content("User D Name")
      end

      it "finds nothing outside the count" do
        visit "/backend/users?page=2&per=26"

        expect(page).to have_content("No users found.")
      end
    end

    describe "excludes" do
      it "does not list deleted User" do
        create(:user, :deleted, name: "Deleted User Name")

        visit "/backend/users"

        expect(page).not_to have_content("Deleted User Name")
      end
    end
  end
end
