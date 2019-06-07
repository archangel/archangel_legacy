# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Frontend - Root Page (HTML)", type: :request do
  describe "with available page" do
    it "returns successfully" do
      create(:page, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "with homepage?" do
    it "redirects to root path when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      create(:page, :homepage, site: site, slug: "amazing")

      get "/amazing"

      expect(response).to redirect_to("/")
    end

    it "returns 301 status when Site homepage_redirect is true" do
      site = create(:site, homepage_redirect: true)
      create(:page, :homepage, site: site, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:moved_permanently)
    end

    it "throws 404 when Site homepage_redirect is false" do
      site = create(:site, homepage_redirect: false)
      create(:page, :homepage, site: site, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "with unavailable page" do
    it "returns 404 when page is unpublished" do
      create(:page, :unpublished, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is future published" do
      create(:page, :future, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:not_found)
    end

    it "returns 404 when page is deleted" do
      create(:page, :deleted, slug: "amazing")

      get "/amazing"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "when page is not found" do
    it "returns 404" do
      get "/amazing"

      expect(response).to have_http_status(:not_found)
    end
  end
end
