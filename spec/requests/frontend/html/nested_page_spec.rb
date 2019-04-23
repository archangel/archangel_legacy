# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Nested Page (HTML)", type: :request do
  describe "with available page" do
    it "returns successfully" do
      parent_a = create(:page, slug: "foo")
      create(:page, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:ok)
    end

    it "returns successfully when parent is unavailable" do
      parent_a = create(:page, :unpublished, slug: "foo")
      create(:page, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "with homepage" do
    it "redirects to root path" do
      parent_a = create(:page, slug: "foo")
      create(:page, :homepage, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response).to redirect_to("/")
      expect(response).to have_http_status(:moved_permanently)
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      parent_a = create(:page, slug: "foo")
      create(:page, :unpublished, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      parent_a = create(:page, slug: "foo")
      create(:page, :future, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      parent_a = create(:page, slug: "foo")
      create(:page, :deleted, parent: parent_a, slug: "bar")

      get "/foo/bar"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404" do
      create(:page, slug: "foo")

      get "/foo/broken"

      expect(response.content_type).to eq("text/html")
      expect(response).to have_http_status(:not_found)
    end
  end
end
