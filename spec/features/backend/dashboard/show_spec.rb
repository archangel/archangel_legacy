# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Dashboard (HTML)", type: :feature do
  describe "showing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    scenario "returns the Dashboard" do
      visit "/backend"

      expect(page).to have_content("Dashboard")
    end
  end
end
