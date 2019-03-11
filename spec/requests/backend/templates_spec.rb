# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Templates", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/templates (#index)" do
    it "returns all Templates" do
      create(:template)
      create(:template, :partial)
      create(:template, :deleted)

      get "/backend/templates"

      expect(assigns(:templates).size).to eq(2)
    end
  end

  describe "GET /backend/templates/:id (#show)" do
    let(:record) { create(:template) }

    describe "with a valid Template id" do
      it "assigns the requested resource as @template" do
        get "/backend/templates/#{record.id}"

        expect(assigns(:template)).to eq(record)
      end
    end

    describe "with an invalid Template id" do
      it "shows the error page" do
        get "/backend/templates/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "GET /backend/templates/new (#new)" do
    it "assigns a new resource as Template" do
      get "/backend/templates/new"

      expect(assigns(:template)).to be_a_new(Archangel::Template)
    end
  end

  describe "POST /backend/templates (#create)" do
    let(:valid_attributes) do
      {
        name: "New Template Name",
        content: %(
          <p>BEFORE TEMPLATE<p>
          <p>{{ content_for_layout }}<p>
          <p>AFTER TEMPLATE<p>
        ),
        partial: false
      }
    end

    describe "with valid attributes" do
      it "redirects to the listing" do
        post "/backend/templates", params: { template: valid_attributes }

        expect(response).to redirect_to(archangel.backend_templates_path)
      end
    end

    describe "with invalid attributes" do
      it "fails without name" do
        invalid_attributes = valid_attributes.merge(name: "")

        post "/backend/templates", params: { template: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails without content" do
        invalid_attributes = valid_attributes.merge(content: "")

        post "/backend/templates", params: { template: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end
    end
  end

  describe "GET /backend/templates/:id/edit (#edit)" do
    let(:record) { create(:template) }

    it "assigns a resource as Template" do
      get "/backend/templates/#{record.id}/edit"

      expect(assigns(:template)).to eq(record)
    end
  end

  describe "PATCH /backend/templates/:id (#update)" do
    let(:record) { create(:template) }

    let(:valid_attributes) do
      {
        name: "Updated Template Name",
        content: %(
          <p>BEFORE TEMPLATE<p>
          <p>{{ content_for_layout }}<p>
          <p>AFTER TEMPLATE<p>
        ),
        partial: false
      }
    end

    describe "with valid attributes" do
      it "redirects after updating resource" do
        patch "/backend/templates/#{record.id}", params: {
          template: valid_attributes
        }

        expect(response).to redirect_to(archangel.backend_templates_path)
      end
    end

    describe "with invalid attributes" do
      it "fails without name" do
        invalid_attributes = valid_attributes.merge(name: "")

        patch "/backend/templates/#{record.id}", params: {
          template: invalid_attributes
        }

        expect(response.body).to include("can&#39;t be blank")
      end
    end
  end

  describe "DELETE /backend/templates/:id (#destroy)" do
    let(:record) { create(:template) }

    it "redirects to the listing" do
      delete "/backend/templates/#{record.id}"

      expect(response).to redirect_to(archangel.backend_templates_path)
    end

    it "ensures the Template no longer accessable" do
      delete "/backend/templates/#{record.id}"
      get "/backend/templates/#{record.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
end
