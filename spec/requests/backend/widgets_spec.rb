# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Widgets", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/widgets (#index)" do
    it "returns all Widgets" do
      create(:widget)
      create(:widget, :deleted)

      get "/backend/widgets"

      expect(assigns(:widgets).size).to eq(1)
    end
  end

  describe "GET /backend/widgets/:slug (#show)" do
    let(:record) { create(:widget, slug: "foo") }

    before { record }

    describe "with a valid Widget slug" do
      it "assigns the requested resource as @widget" do
        get "/backend/widgets/foo"

        expect(assigns(:widget)).to eq(record)
      end
    end

    describe "with an invalid Widget slug" do
      it "shows the error page" do
        get "/backend/widgets/unknown"

        expect(response).to have_http_status(:not_found)
        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "GET /backend/widgets/new (#new)" do
    it "assigns a new resource as Widget" do
      get "/backend/widgets/new"

      expect(assigns(:widget)).to be_a_new(Archangel::Widget)
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

        expect(response).to redirect_to(archangel.backend_widgets_path)
      end
    end

    describe "with invalid attributes" do
      it "fails without name" do
        invalid_attributes = valid_attributes.merge(name: "")

        post "/backend/widgets", params: { widget: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails without content" do
        invalid_attributes = valid_attributes.merge(content: "")

        post "/backend/widgets", params: { widget: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails without slug" do
        invalid_attributes = valid_attributes.merge(slug: "")

        post "/backend/widgets", params: { widget: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails with duplicate slug" do
        create(:widget, slug: "foo")

        invalid_attributes = valid_attributes.merge(slug: "foo")

        post "/backend/widgets", params: { widget: invalid_attributes }

        expect(response.body).to include("has already been taken")
      end
    end
  end

  describe "GET /backend/widgets/:slug/edit (#edit)" do
    let(:record) { create(:widget, slug: "foo") }

    before { record }

    it "assigns a resource as Widget" do
      get "/backend/widgets/foo/edit"

      expect(assigns(:widget)).to eq(record)
    end
  end

  describe "PATCH /backend/widgets/:slug (#update)" do
    let(:record) { create(:widget, slug: "foo") }

    let(:valid_attributes) do
      {
        name: "Updated Widget Name",
        slug: "foo",
        content: "<p>Updated widget content</p>"
      }
    end

    before { record }

    describe "with valid attributes" do
      it "redirects after updating resource" do
        patch "/backend/widgets/foo", params: { widget: valid_attributes }

        expect(response).to redirect_to(archangel.backend_widgets_path)
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
    let(:record) { create(:widget, slug: "foo") }

    before { record }

    it "redirects to the listing" do
      delete "/backend/widgets/foo"

      expect(response).to redirect_to(archangel.backend_widgets_path)
    end

    it "ensures the Widget no longer accessable" do
      delete "/backend/widgets/foo"
      get "/backend/widgets/foo"

      expect(response).to have_http_status(:not_found)
    end
  end
end
