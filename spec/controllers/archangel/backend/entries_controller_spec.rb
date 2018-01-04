# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe EntriesController, type: :controller do
      before { stub_authorization! }

      let(:site) { create(:site) }
      let(:collection) { create(:collection, site: site) }
      let(:field) { create(:field, collection: collection, slug: "slug") }

      describe "GET #index" do
        it "assigns all resources as @entries" do
          entry_a = create(:entry,
                           collection: collection,
                           value: ActiveSupport::JSON.encode(slug: "first"))
          entry_b = create(:entry,
                           collection: collection,
                           value: ActiveSupport::JSON.encode(slug: "second"))
          entry_c = create(:entry,
                           collection: collection,
                           value: ActiveSupport::JSON.encode(slug: "third"))

          get :index, params: { collection_id: collection }

          expect(assigns(:collection)).to eq(collection)
          expect(assigns(:entries)).to eq([entry_c, entry_b, entry_a])
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @entry" do
          entry = create(:entry, collection: collection)

          get :show, params: { collection_id: collection, id: entry }

          expect(assigns(:collection)).to eq(collection)
          expect(assigns(:entry)).to eq(entry)
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Entry" do
          get :new, params: { collection_id: collection }

          expect(assigns(:entry)).to be_a_new(Entry)
        end
      end

      describe "POST #create" do
        let!(:collection) { create(:collection) }
        let!(:field) do
          create(:field, collection: collection, slug: "slug", required: true)
        end

        context "with valid params" do
          let(:params) do
            {
              value: {
                slug: "new-collection-entry"
              },
              available_at: Time.current
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: {
                collection_id: collection,
                collection_entry: params
              }
            end.to change(Entry, :count).by(1)
          end

          it "assigns a newly created resource as @entry" do
            post :create, params: {
              collection_id: collection,
              collection_entry: params
            }

            expect(assigns(:entry)).to be_a(Entry)
            expect(assigns(:entry)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: {
              collection_id: collection,
              collection_entry: params
            }

            expect(response).to(
              redirect_to(backend_collection_entries_path(collection))
            )
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              value: {
                foo: "bar"
              }
            }
          end

          it "assigns a newly created but unsaved resource as @entry" do
            post :create, params: {
              collection_id: collection,
              collection_entry: params
            }

            expect(assigns(:entry)).to be_a_new(Entry)
          end

          it "re-renders the `new` view" do
            post :create, params: {
              collection_id: collection,
              collection_entry: params
            }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @entry" do
          entry = create(:entry, collection: collection)

          get :edit, params: { collection_id: collection, id: entry }

          expect(assigns(:collection)).to eq(collection)
          expect(assigns(:entry)).to eq(entry)
        end
      end

      describe "PUT #update" do
        let!(:collection) { create(:collection) }
        let!(:field) do
          create(:field, collection: collection, slug: "slug", required: true)
        end
        let!(:entry) do
          create(:entry, collection: collection,
                         value: ActiveSupport::JSON.encode(slug: "entry-slug"))
        end

        context "with valid params" do
          let(:params) do
            {
              value: {
                slug: "updated-entry-slug"
              }
            }
          end

          it "updates the requested resource" do
            put :update, params: {
              collection_id: collection,
              id: entry,
              collection_entry: params
            }

            expect(assigns(:entry)).to eq(entry)
          end

          it "assigns the requested resource as @collection" do
            put :update, params: {
              collection_id: collection,
              id: entry,
              collection_entry: params
            }

            expect(assigns(:entry)).to eq(entry)
          end

          it "redirects after updating resource" do
            put :update, params: {
              collection_id: collection,
              id: entry,
              collection_entry: params
            }

            expect(response).to(
              redirect_to(backend_collection_entries_path(collection))
            )
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              value: {
                foo: "bar"
              }
            }
          end

          it "assigns the resource as @entry" do
            put :update, params: {
              collection_id: collection,
              id: entry,
              collection_entry: params
            }

            expect(assigns(:entry)).to eq(entry)
          end

          it "re-renders the `edit` view" do
            put :update, params: {
              collection_id: collection,
              id: entry,
              collection_entry: params
            }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          entry = create(:entry, collection: collection)

          expect do
            delete :destroy, params: { collection_id: collection, id: entry }
          end.to change(Entry, :count).by(-1)
        end

        it "redirects to the listing" do
          entry = create(:entry, collection: collection)

          delete :destroy, params: { collection_id: collection, id: entry }

          expect(response).to(
            redirect_to(backend_collection_entries_path(collection))
          )
        end
      end

      describe "POST #sort" do
        let!(:collection) { create(:collection) }
        let!(:field) do
          create(:field, collection: collection, slug: "slug", required: true)
        end

        it "assigns all resources as @entries" do
          entry_a = create(:entry,
                           collection: collection,
                           value: ActiveSupport::JSON.encode(slug: "first"))
          entry_b = create(:entry,
                           collection: collection,
                           value: ActiveSupport::JSON.encode(slug: "second"))

          params = {
            sort: [entry_a.id, entry_b.id]
          }

          post :sort, params: {
            collection_id: collection,
            collection_entry: params
          }

          expect(response).to have_http_status(:accepted)
        end
      end
    end
  end
end
