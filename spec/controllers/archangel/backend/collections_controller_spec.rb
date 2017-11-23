# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe CollectionsController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all resources as @collections" do
          site = create(:site)

          collection_a = create(:collection, site: site, name: "First")
          collection_b = create(:collection, site: site, name: "Second")
          collection_c = create(:collection, site: site, name: "Third")

          get :index

          expect(assigns(:collections)).to eq(
            [collection_a, collection_b, collection_c]
          )
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @collection" do
          collection = create(:collection)

          get :show, params: { id: collection }

          expect(assigns(:collection)).to eq(collection)
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Collection" do
          get :new

          expect(assigns(:collection)).to be_a_new(Collection)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "New Collection Name",
              slug: "new-collection",
              fields_attributes: [{
                classification: "string",
                label: "Field Label",
                slug: "field_slug",
                required: false
              }]
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: { collection: params }
            end.to change(Collection, :count).by(1)
          end

          it "assigns a newly created resource as @collection" do
            post :create, params: { collection: params }

            expect(assigns(:collection)).to be_a(Collection)
            expect(assigns(:collection)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: { collection: params }

            expect(response).to redirect_to(backend_collections_path)
          end

          it "creates fields with resource" do
            expect do
              post :create, params: { collection: params }
            end.to change(Field, :count).by(1)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              slug: nil,
              fields_attributes: [{
                classification: "unknown",
                label: nil,
                slug: nil,
                required: 2
              }]
            }
          end

          it "assigns a newly created but unsaved resource as @collection" do
            post :create, params: { collection: params }

            expect(assigns(:collection)).to be_a_new(Collection)
          end

          it "re-renders the `new` view" do
            post :create, params: { collection: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @collection" do
          collection = create(:collection)

          get :edit, params: { id: collection }

          expect(assigns(:collection)).to eq(collection)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              name: "Updated Collection Name",
              slug: "updated-collection"
            }
          end

          it "updates the requested resource" do
            collection = create(:collection, :with_fields, fields_count: 1)

            put :update, params: { id: collection, collection: params }

            collection.reload

            expect(assigns(:collection)).to eq(collection)
          end

          it "assigns the requested resource as @collection" do
            collection = create(:collection, :with_fields, fields_count: 1)

            put :update, params: { id: collection, collection: params }

            expect(assigns(:collection)).to eq(collection)
          end

          it "redirects after updating resource" do
            collection = create(:collection, :with_fields, fields_count: 1)

            put :update, params: { id: collection, collection: params }

            expect(response).to redirect_to(backend_collections_path)
          end

          it "updates a field on the resource" do
            collection = create(:collection, :with_fields, fields_count: 1)

            field_params = params.merge(fields_attributes: [{
                                          id: collection.fields.first.id,
                                          classification: "string",
                                          label: "Updated Field Label",
                                          slug: "updated_field_slug",
                                          required: false
                                        }])

            expect do
              post :update, params: { id: collection, collection: field_params }
            end.to_not change(Field, :count)
          end

          it "adds a field to the resource" do
            collection = create(:collection, :with_fields, fields_count: 1)

            field_params = params.merge(fields_attributes: [{
                                          classification: "string",
                                          label: "Updated Field Label",
                                          slug: "updated_field_slug",
                                          required: false
                                        }])

            expect do
              post :update, params: { id: collection, collection: field_params }
            end.to change(Field, :count).by(1)
          end

          it "removes a field to the resource" do
            collection = create(:collection, :with_fields, fields_count: 1)

            field_params = params.merge(fields_attributes: [{
                                          id: collection.fields.first.id,
                                          classification: "string",
                                          label: "Updated Field Label",
                                          slug: "updated_field_slug",
                                          required: false,
                                          _destroy: true
                                        }])

            expect do
              post :update, params: { id: collection, collection: field_params }
            end.to change(Field, :count).by(-1)
          end
        end

        context "with invalid params" do
          let(:collection) do
            create(:collection, :with_fields, fields_count: 1)
          end

          let(:params) do
            {
              name: nil,
              slug: nil
            }
          end

          it "assigns the resource as @collection" do
            put :update, params: { id: collection, collection: params }

            expect(assigns(:collection)).to eq(collection)
          end

          it "re-renders the `edit` view" do
            put :update, params: { id: collection, collection: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          collection = create(:collection)

          expect do
            delete :destroy, params: { id: collection }
          end.to change(Collection, :count).by(-1)
        end

        it "redirects to the listing" do
          collection = create(:collection)

          delete :destroy, params: { id: collection }

          expect(response).to redirect_to(backend_collections_path)
        end
      end
    end
  end
end
