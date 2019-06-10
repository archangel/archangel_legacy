# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Dashboard (HTML)", type: :feature do
  describe "showing" do
    before { stub_authorization!(profile) }

    let(:profile) { create(:user) }

    it "returns 200 status" do
      visit "/backend"

      expect(page.status_code).to eq 200
    end
  end
end
