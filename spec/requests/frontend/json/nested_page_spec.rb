# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Nested Page (JSON)", type: :request do
  describe "with available page" do
    let(:parent_page) { create(:page, slug: "amazing") }

    it "returns successfully" do
      create(:page, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end

    it "returns successfully with JSON schema" do
      create(:page, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/pages/show")
    end

    it "returns successfully when parent is unavailable?" do
      parent_page = create(:page, :deleted, slug: "amazing")

      create(:page, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "with homepage?" do
    let(:site) { create(:site, homepage_redirect: true) }

    it "redirects to root path when Site homepage_redirect is true" do
      parent_page = create(:page, site: site, slug: "amazing")
      create(:page, :homepage, site: site, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to redirect_to("/")
    end

    it "returns 301 status when Site homepage_redirect is true" do
      parent_page = create(:page, site: site, slug: "amazing")
      create(:page, :homepage, site: site, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:moved_permanently)
    end

    it "throws 404 when Site homepage_redirect is false" do
      site = create(:site, homepage_redirect: false)
      parent_page = create(:page, site: site, slug: "amazing")
      create(:page, :homepage, site: site, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with unavailable page" do
    let(:parent_page) { create(:page, slug: "amazing") }

    it "returns 404 when page is unpublished" do
      create(:page, :unpublished, parent: parent_page, slug: "grace")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      create(:page, :future, parent: parent_page, slug: "grace")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      create(:page, :deleted, parent: parent_page, slug: "grace")

      get "/foo/bar", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404 status" do
      create(:page, slug: "amazing")

      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 with JSON schema" do
      get "/amazing/grace", headers: { accept: "application/json" }

      expect(response).to match_response_schema("frontend/errors/not_found")
    end
  end
end
