# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe PagesController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all resources as @pages" do
          site = create(:site)

          page_a = create(:page, site: site, title: "First")
          page_b = create(:page, site: site, title: "Second")
          page_c = create(:page, site: site, title: "Third")

          get :index

          expect(assigns(:pages)).to eq([page_a, page_b, page_c])
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @page" do
          page = create(:page)

          get :show, params: { id: page }

          expect(assigns(:page)).to eq(page)
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Page" do
          get :new

          expect(assigns(:page)).to be_a_new(Page)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              title: "New Page Title",
              content: "<p>New page content</p>",
              slug: "awesome-page",
              metatags_attributes: [
                {
                  name: "description",
                  content: "Description for the Page"
                },
                {
                  name: "keywords",
                  content: "keywords,for,the,Page"
                }
              ]
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: { page: params }
            end.to change(Page, :count).by(1)
          end

          it "creates Metatag resources" do
            expect do
              post :create, params: { page: params }
            end.to change(Metatag, :count).by(2)
          end

          it "assigns a newly created resource as @page" do
            post :create, params: { page: params }

            expect(assigns(:page)).to be_a(Page)
            expect(assigns(:page)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: { page: params }

            expect(response).to redirect_to(backend_pages_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              title: nil,
              content: nil,
              slug: nil
            }
          end

          it "assigns a newly created but unsaved resource as @page" do
            post :create, params: { page: params }

            expect(assigns(:page)).to be_a_new(Page)
          end

          it "re-renders the `new` view" do
            post :create, params: { page: params }

            expect(response).to render_template(:new)
          end
        end

        context "with restricted path" do
          %w[account backend].each do |restricted_path|
            it "does not allow restricted `#{restricted_path}` path" do
              params = {
                title: "Example Page",
                content: "<p>Example page.</p>",
                slug: restricted_path
              }

              post :create, params: { page: params }

              expect(assigns(:page)).to be_a_new(Page)
            end
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @page" do
          page = create(:page)

          get :edit, params: { id: page }

          expect(assigns(:page)).to eq(page)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              title: "Updated Page Title",
              content: "<p>Updated page content</p>",
              slug: "updated-awesome-page"
            }
          end

          it "updates the requested resource" do
            page = create(:page)

            put :update, params: { id: page, page: params }

            page.reload

            expect(assigns(:page)).to eq(page)
          end

          it "assigns the requested resource as @page" do
            page = create(:page)

            put :update, params: { id: page, page: params }

            expect(assigns(:page)).to eq(page)
          end

          it "redirects after updating resource" do
            page = create(:page)

            put :update, params: { id: page, page: params }

            expect(response).to redirect_to(backend_pages_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              title: nil,
              content: nil,
              slug: nil
            }
          end

          it "assigns the resource as @page" do
            page = create(:page)

            put :update, params: { id: page, page: params }

            expect(assigns(:page)).to eq(page)
          end

          it "re-renders the `edit` view" do
            page = create(:page)

            put :update, params: { id: page, page: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          page = create(:page)

          expect do
            delete :destroy, params: { id: page }
          end.to change(Page, :count).by(-1)
        end

        it "redirects to the listing" do
          page = create(:page)

          delete :destroy, params: { id: page }

          expect(response).to redirect_to(backend_pages_path)
        end
      end
    end
  end
end
