# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Page", type: :request do
  describe "with available page" do
    let!(:resource) { create(:page, slug: "foo") }

    it "returns successfully" do
      get "/foo"

      expect(response).to be_successful
    end
  end

  describe "with available page as JSON" do
    let!(:resource) { create(:page, slug: "foo") }

    it "returns successfully" do
      get "/foo", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/pages/show")
    end
  end

  describe "with homepage" do
    let!(:resource) { create(:page, :homepage, slug: "foo") }

    it "redirects to root path" do
      get "/foo"

      expect(response).to redirect_to("/")
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      create(:page, :unpublished, slug: "foo")

      get "/foo"

      expect(response).to be_not_found
    end

    it "returns 404 when page is future published" do
      create(:page, :future, slug: "foo")

      get "/foo"

      expect(response).to be_not_found
    end

    it "returns 404 when page is deleted" do
      create(:page, :deleted, slug: "foo")

      get "/foo"

      expect(response).to be_not_found
    end
  end

  describe "when page is not found" do
    it "returns 404" do
      get "/broken"

      expect(response).to be_not_found
    end
  end

  describe "with available page as JSON" do
    it "returns successfully" do
      get "/broken", headers: { accept: "application/json" }

      expect(response).to be_not_found
      expect(response).to match_response_schema("frontend/errors/not_found")
    end
  end
end
