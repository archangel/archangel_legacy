# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe SitesController, type: :controller do
      before { stub_authorization! create(:user) }

      describe "GET #show" do
        it "assigns the requested site as @site" do
          get :show

          expect(assigns(:site)).to eq(Site.current)
        end
      end

      describe "GET #edit" do
        it "assigns the requested site as @site" do
          get :edit

          expect(assigns(:site)).to eq(Site.current)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              name: "My Archangel Site Name"
            }
          end

          it "updates the requested setting" do
            put :update, params: { site: params }

            Site.current.reload

            expect(assigns(:site)).to eq(Site.current)
          end

          it "redirects to the collection" do
            put :update, params: { site: params }

            expect(response).to redirect_to(backend_site_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil
            }
          end

          it "assigns the site as @site" do
            put :update, params: { site: params }

            expect(assigns(:site)).to eq(Site.current)
          end

          it "re-renders the `edit` template" do
            put :update, params: { site: params }

            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
