# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Site", type: :request do
  describe "without authorization" do
    before { stub_authorization!(create(:user)) }

    describe "PATCH /backend/site (#update)" do
      before { create(:site) }

      it "returns unauthorized" do
        patch "/backend/site", params: { site: { name: "Site Name" } }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body)
          .to include("Access is denied due to invalid credentials")
      end
    end
  end

  describe "with authorization" do
    before { stub_authorization!(create(:user, :admin)) }

    describe "GET /backend/site (#show)" do
      let(:record) { create(:site) }

      before { record }

      describe "with a valid Site" do
        it "assigns the requested resource as @site" do
          get "/backend/site"

          expect(assigns(:site)).to eq(record)
        end
      end
    end

    describe "PATCH /backend/site (#update)" do
      let(:record) { create(:site) }

      before { record }

      let(:valid_attributes) do
        {
          name: "Updated Site Name",
          locale: "en"
        }
      end

      describe "with valid attributes" do
        it "redirects after updating resource" do
          patch "/backend/site", params: { site: valid_attributes }

          expect(response).to redirect_to(archangel.backend_site_path)
        end
      end

      describe "with invalid attributes" do
        it "fails with unrecognized locale" do
          invalid_attributes = valid_attributes.merge(locale: "foo")

          patch "/backend/site", params: { site: invalid_attributes }

          expect(response.body).to include("is not included in the list")
        end
      end
    end
  end
end
