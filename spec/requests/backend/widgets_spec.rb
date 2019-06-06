# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/widgets/:slug (#show)" do
    before { create(:widget, slug: "foo") }

    describe "with a valid Widget slug" do
      it "returns a 200 status" do
        get "/backend/widgets/foo"

        expect(response).to have_http_status(:ok)
      end
    end

    describe "with an invalid Widget slug" do
      it "returns a 404 status" do
        get "/backend/widgets/unknown"

        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        get "/backend/widgets/unknown"

        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "POST /backend/widgets (#create)" do
    let(:valid_attributes) do
      {
        name: "New Widget Name",
        slug: "foo",
        content: "<p>Content of the new Widget</p>"
      }
    end

    describe "with valid attributes" do
      it "redirects to the listing" do
        post "/backend/widgets", params: { widget: valid_attributes }

        expect(response).to redirect_to("/backend/widgets")
      end
    end
  end

  describe "GET /backend/widgets/:slug/edit (#edit)" do
    before { create(:widget, slug: "foo") }

    it "returns a 200 status" do
      get "/backend/widgets/foo/edit"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /backend/widgets/:slug (#update)" do
    let(:valid_attributes) do
      {
        name: "Updated Widget Name",
        slug: "foo",
        content: "<p>Updated widget content</p>"
      }
    end

    before { create(:widget, slug: "foo") }

    describe "with valid attributes" do
      it "redirects after updating resource" do
        patch "/backend/widgets/foo", params: { widget: valid_attributes }

        expect(response).to redirect_to("/backend/widgets")
      end
    end

    describe "with invalid attributes" do
      it "fails without name" do
        invalid_attributes = valid_attributes.merge(name: "")

        patch "/backend/widgets/foo", params: { widget: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end
    end
  end

  describe "DELETE /backend/widgets/:slug (#destroy)" do
    before { create(:widget, slug: "foo") }

    it "redirects to the listing" do
      delete "/backend/widgets/foo"

      expect(response).to redirect_to("/backend/widgets")
    end

    it "ensures the Widget no longer accessable" do
      delete "/backend/widgets/foo"
      get "/backend/widgets/foo"

      expect(response).to have_http_status(:not_found)
    end
  end
end
