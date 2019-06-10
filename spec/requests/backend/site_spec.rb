# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site", type: :request do
  describe "without authorization" do
    before { stub_authorization!(create(:user)) }

    describe "PATCH /backend/site (#update)" do
      before { create(:site) }

      it "returns 401 status" do
        patch "/backend/site", params: { site: { name: "Site Name" } }

        expect(response).to have_http_status(:unauthorized)
      end

      it "returns unauthorized error message" do
        patch "/backend/site", params: { site: { name: "Site Name" } }

        expect(response.body)
          .to include("Access is denied due to invalid credentials")
      end
    end
  end

  describe "with authorization" do
    before { stub_authorization!(create(:user, :admin)) }

    describe "GET /backend/site (#show)" do
      before { create(:site) }

      it "returns 200 status" do
        get "/backend/site"

        expect(response).to have_http_status(:ok)
      end
    end

    describe "PATCH /backend/site (#update)" do
      let(:valid_attributes) do
        {
          name: "Updated Site Name",
          locale: "en"
        }
      end

      before { create(:site) }

      it "redirects after updating resource with valid attributes" do
        patch "/backend/site", params: { site: valid_attributes }

        expect(response).to redirect_to("/backend/site")
      end

      it "fails with unrecognized locale" do
        invalid_attributes = valid_attributes.merge(locale: "foo")

        patch "/backend/site", params: { site: invalid_attributes }

        expect(response.body).to include("is not included in the list")
      end
    end
  end
end
