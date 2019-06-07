# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/pages/:id (#show)" do
    let(:record) { create(:page) }

    describe "with a valid Page id" do
      it "returns a 200 status" do
        get "/backend/pages/#{record.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    describe "with an invalid Page id" do
      it "returns a 404 status" do
        get "/backend/pages/0"

        expect(response).to have_http_status(:not_found)
      end

      it "shows the error message" do
        get "/backend/pages/0"

        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "POST /backend/pages (#create)" do
    let(:valid_attributes) do
      {
        title: "New Page Title",
        content: "<p>New page content</p>",
        slug: "foo"
      }
    end

    describe "with valid attributes" do
      it "redirects to the listing" do
        post "/backend/pages", params: { page: valid_attributes }

        expect(response).to redirect_to("/backend/pages")
      end
    end
  end

  describe "GET /backend/pages/:id/edit (#edit)" do
    let(:record) { create(:page) }

    it "returns a 200 status" do
      get "/backend/pages/#{record.id}/edit"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /backend/pages/:id (#update)" do
    let(:record) { create(:page) }

    let(:valid_attributes) do
      {
        title: "Updated Page Title",
        content: "<p>Updated page content</p>",
        slug: "foo"
      }
    end

    describe "with valid attributes" do
      it "redirects after updating resource" do
        patch "/backend/pages/#{record.id}", params: {
          page: valid_attributes
        }

        expect(response).to redirect_to("/backend/pages")
      end
    end

    describe "with invalid attributes" do
      it "fails without title" do
        invalid_attributes = valid_attributes.merge(title: "")

        patch "/backend/pages/#{record.id}", params: {
          page: invalid_attributes
        }

        expect(response.body).to include("can&#39;t be blank")
      end
    end
  end

  describe "DELETE /backend/pages/:id (#destroy)" do
    let(:record) { create(:page) }

    it "redirects to the listing" do
      delete "/backend/pages/#{record.id}"

      expect(response).to redirect_to("/backend/pages")
    end

    it "ensures the Page no longer accessable" do
      delete "/backend/pages/#{record.id}"
      get "/backend/pages/#{record.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
end
