# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Homepage (JSON)", type: :request do
  describe "with available homepage" do
    it "returns successfully" do
      create(:page, :homepage)

      get "/", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end

    it "returns successfully with JSON schema" do
      create(:page, :homepage)

      get "/", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/pages/show")
    end
  end

  describe "with unavailable homepage" do
    it "returns 404 when homepage is unpublished" do
      create(:page, :homepage, :unpublished)

      get "/", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when homepage is future published" do
      create(:page, :homepage, :future)

      get "/", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when homepage is deleted" do
      create(:page, :homepage, :deleted)

      get "/", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with multiple homepages" do
    before do
      create(:page, :homepage, content: "First")

      second_homepage = create(:page, content: "Second")
      second_homepage.update_column(:homepage, true)
    end

    it "returns the first available" do
      get "/", headers: { accept: "application/json" }

      json_response = JSON.parse(response.body)

      expect(json_response["page"]["content"]).to eq("First")
    end
  end

  describe "without a homepage" do
    it "returns 404 status" do
      get "/", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 with JSON schema" do
      get "/", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/errors/not_found")
    end
  end
end
