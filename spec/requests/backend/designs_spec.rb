# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Designs", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/designs/:id (#show)" do
    let(:record) { create(:design) }

    describe "with a valid Design id" do
      it "assigns the requested resource as @design" do
        get "/backend/designs/#{record.id}"

        expect(assigns(:design)).to eq(record)
      end
    end

    describe "with an invalid Design id" do
      it "shows the error page" do
        get "/backend/designs/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "POST /backend/designs (#create)" do
    let(:valid_attributes) do
      {
        name: "New Design Name",
        content: %(
          <p>BEFORE DESIGN<p>
          <p>{{ content_for_layout }}<p>
          <p>AFTER DESIGN<p>
        ),
        partial: false
      }
    end

    describe "with valid attributes" do
      it "redirects to the listing" do
        post "/backend/designs", params: { design: valid_attributes }

        expect(response).to redirect_to(archangel.backend_designs_path)
      end
    end
  end

  describe "GET /backend/designs/:id/edit (#edit)" do
    let(:record) { create(:design) }

    it "assigns a resource as Design" do
      get "/backend/designs/#{record.id}/edit"

      expect(assigns(:design)).to eq(record)
    end
  end

  describe "PATCH /backend/designs/:id (#update)" do
    let(:record) { create(:design) }

    let(:valid_attributes) do
      {
        name: "Updated Design Name",
        content: %(
          <p>BEFORE DESIGN<p>
          <p>{{ content_for_layout }}<p>
          <p>AFTER DESIGN<p>
        ),
        partial: false
      }
    end

    describe "with valid attributes" do
      it "redirects after updating resource" do
        patch "/backend/designs/#{record.id}", params: {
          design: valid_attributes
        }

        expect(response).to redirect_to(archangel.backend_designs_path)
      end
    end

    describe "with invalid attributes" do
      it "fails without name" do
        invalid_attributes = valid_attributes.merge(name: "")

        patch "/backend/designs/#{record.id}", params: {
          design: invalid_attributes
        }

        expect(response.body).to include("can&#39;t be blank")
      end
    end
  end

  describe "DELETE /backend/designs/:id (#destroy)" do
    let(:record) { create(:design) }

    it "redirects to the listing" do
      delete "/backend/designs/#{record.id}"

      expect(response).to redirect_to(archangel.backend_designs_path)
    end

    it "ensures the Design no longer accessable" do
      delete "/backend/designs/#{record.id}"
      get "/backend/designs/#{record.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
end
