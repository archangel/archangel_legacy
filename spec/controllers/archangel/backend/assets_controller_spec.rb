# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe AssetsController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all resources as @assets" do
          asset_a = create(:asset, file_name: "first.jpg")
          asset_b = create(:asset, file_name: "second.jpg")
          asset_c = create(:asset, file_name: "third.jpg")

          get :index

          expect(assigns(:assets)).to eq(
            [asset_a, asset_b, asset_c]
          )
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @asset" do
          asset = create(:asset)

          get :show, params: { id: asset }

          expect(assigns(:asset)).to eq(asset)
        end

        it "uses default image for not-image assets" do
          asset = create(:asset, :stylesheet)

          get :show, params: { id: asset }

          expect(asset.file.url).to include("/uploads/archangel/asset/file")
          expect(asset.file.small.url).to(
            include("/assets/archangel/fallback/small_asset")
          )
        end

        it "uses uploaded image for image assets" do
          asset = create(:asset)

          get :show, params: { id: asset }

          expect(asset.file.url).to include("/uploads/archangel/asset/file")
          expect(asset.file.small.url).to(
            include("/uploads/archangel/asset/file")
          )
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Asset" do
          get :new

          expect(assigns(:asset)).to be_a_new(Asset)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              file_name: "new-file.jpg",
              file: fixture_file_upload(uploader_test_image)
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: { asset: params }
            end.to change(Asset, :count).by(1)
          end

          it "assigns a newly created resource as @asset" do
            post :create, params: { asset: params }

            expect(assigns(:asset)).to be_a(Asset)
            expect(assigns(:asset)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: { asset: params }

            expect(response).to redirect_to(backend_assets_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              file_name: nil,
              file: nil
            }
          end

          it "assigns a newly created but unsaved resource as @asset" do
            post :create, params: { asset: params }

            expect(assigns(:asset)).to be_a_new(Asset)
          end

          it "re-renders the `new` view" do
            post :create, params: { asset: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @asset" do
          asset = create(:asset)

          get :edit, params: { id: asset }

          expect(assigns(:asset)).to eq(asset)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              file_name: "updated-file.jpg",
              file: fixture_file_upload(uploader_test_image)
            }
          end

          it "updates the requested resource" do
            asset = create(:asset)

            put :update, params: { id: asset, asset: params }

            asset.reload

            expect(assigns(:asset)).to eq(asset)
          end

          it "assigns the requested resource as @asset" do
            asset = create(:asset)

            put :update, params: { id: asset, asset: params }

            expect(assigns(:asset)).to eq(asset)
          end

          it "redirects after updating resource" do
            asset = create(:asset)

            put :update, params: { id: asset, asset: params }

            expect(response).to redirect_to(backend_assets_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              file_name: nil,
              file: nil
            }
          end

          it "assigns the resource as @asset" do
            asset = create(:asset)

            put :update, params: { id: asset, asset: params }

            expect(assigns(:asset)).to eq(asset)
          end

          it "re-renders the `edit` view" do
            asset = create(:asset)

            put :update, params: { id: asset, asset: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          asset = create(:asset)

          expect do
            delete :destroy, params: { id: asset }
          end.to change(Asset, :count).by(-1)
        end

        it "redirects to the listing" do
          asset = create(:asset)

          delete :destroy, params: { id: asset }

          expect(response).to redirect_to(backend_assets_path)
        end
      end
    end
  end
end
