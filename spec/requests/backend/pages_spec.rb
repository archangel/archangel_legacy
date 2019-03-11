# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "GET /backend/pages (#index)" do
    it "returns all Pages" do
      create(:page)
      create(:page, :unpublished)
      create(:page, :future)

      get "/backend/pages"

      expect(assigns(:pages).size).to eq(3)
    end
  end

  describe "GET /backend/pages/:id (#show)" do
    let(:record) { create(:page) }

    describe "with a valid Page id" do
      it "assigns the requested resource as @page" do
        get "/backend/pages/#{record.id}"

        expect(assigns(:page)).to eq(record)
      end
    end

    describe "with an invalid Page id" do
      it "shows the error page" do
        get "/backend/pages/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body)
          .to include("Page not found. Could not find what was requested")
      end
    end
  end

  describe "GET /backend/pages/new (#new)" do
    it "assigns a new resource as Page" do
      get "/backend/pages/new"

      expect(assigns(:page)).to be_a_new(Archangel::Page)
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

        expect(response).to redirect_to(archangel.backend_pages_path)
      end

      it "creates Metatag resources" do
        metatags_attributes = [
          {
            name: "description",
            content: "Description for the Page"
          },
          {
            name: "keywords",
            content: "keywords,for,the,page"
          }
        ]

        valid_metatag_attributes = valid_attributes.merge(
          metatags_attributes: metatags_attributes
        )

        expect do
          post "/backend/pages", params: { page: valid_metatag_attributes }
        end.to change(Archangel::Metatag, :count).by(2)
      end
    end

    describe "with invalid attributes" do
      it "fails without title" do
        invalid_attributes = valid_attributes.merge(title: "")

        post "/backend/pages", params: { page: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails without content" do
        invalid_attributes = valid_attributes.merge(content: "")

        post "/backend/pages", params: { page: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails without slug" do
        invalid_attributes = valid_attributes.merge(slug: "")

        post "/backend/pages", params: { page: invalid_attributes }

        expect(response.body).to include("can&#39;t be blank")
      end

      it "fails with duplicate slug" do
        create(:page, slug: "foo")

        invalid_attributes = valid_attributes.merge(slug: "foo")

        post "/backend/pages", params: { page: invalid_attributes }

        expect(response.body).to include("has already been taken")
      end

      %w[account backend].each do |reserved_path|
        it "fails with reserved path" do
          invalid_attributes = valid_attributes.merge(slug: reserved_path)

          post "/backend/pages", params: { page: invalid_attributes }

          expect(response.body).to include("contains restricted path")
        end
      end
    end
  end

  describe "GET /backend/pages/:id/edit (#edit)" do
    let(:record) { create(:page) }

    it "assigns a resource as Page" do
      get "/backend/pages/#{record.id}/edit"

      expect(assigns(:page)).to eq(record)
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

        expect(response).to redirect_to(archangel.backend_pages_path)
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

    describe "with invalid Liquid format" do
      it "fails with goofy Widget tag" do
        invalid_attributes = valid_attributes.merge(
          content: "{% widget %}"
        )

        patch "/backend/pages/#{record.id}", params: {
          page: invalid_attributes
        }

        expect(response.body).to include("contains invalid Liquid formatting")
      end
    end
  end

  describe "DELETE /backend/pages/:id (#destroy)" do
    let(:record) { create(:page) }

    it "redirects to the listing" do
      delete "/backend/pages/#{record.id}"

      expect(response).to redirect_to(archangel.backend_pages_path)
    end

    it "ensures the Page no longer accessable" do
      delete "/backend/pages/#{record.id}"
      get "/backend/pages/#{record.id}"

      expect(response).to have_http_status(:not_found)
    end
  end
end
