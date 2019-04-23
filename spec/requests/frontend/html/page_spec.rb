# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Root Page (HTML)", type: :request do
  describe "with available page" do
    it "returns successfully" do
      create(:page, slug: "foo")

      get "/foo"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:ok)
    end

    it "returns successfully when parent is unavailable" do
      create(:page, :unpublished, slug: "foo")

      get "/foo"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with homepage" do
    it "redirects to root path" do
      create(:page, :homepage, slug: "foo")

      get "/foo"

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      create(:page, :unpublished, slug: "foo")

      get "/foo"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      create(:page, :future, slug: "foo")

      get "/foo"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      create(:page, :deleted, slug: "foo")

      get "/foo"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404" do
      get "/broken"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end
  end
end
