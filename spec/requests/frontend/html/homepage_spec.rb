# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Homepage (HTML)", type: :request do
  describe "with available homepage" do
    it "returns successfully" do
      create(:page, :homepage)

      get "/"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "with unavailable homepage" do
    it "returns 404 when homepage is unpublished" do
      create(:page, :homepage, :unpublished)

      get "/"

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when homepage is future published" do
      create(:page, :homepage, :future)

      get "/"

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when homepage is deleted" do
      create(:page, :homepage, :deleted)

      get "/"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with multiple homepages" do
    before do
      create(:page, :homepage, content: "Amazing")

      second_homepage = create(:page, content: "Grace")
      second_homepage.update_column(:homepage, true)
    end

    it "returns the first available" do
      get "/"

      expect(response.body).to include("Amazing")
    end

    it "does not return the second available" do
      get "/"

      expect(response.body).not_to include("Grace")
    end
  end

  describe "without a homepage" do
    it "returns 404 status" do
      get "/"

      expect(response).to have_http_status(:not_found)
    end
  end
end
