# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe SitesController, type: :controller do
      before { stub_authorization! profile }

      let!(:site) { create(:site) }

      describe "GET #show" do
        let!(:profile) { create(:user, :editor, site: site) }

        it "assigns the requested site as @site" do
          get :show

          expect(assigns(:site)).to eq(site)
        end

        it "uses default favicon for site" do
          get :show

          expect(site.favicon.url).to(
            include("/assets/archangel/fallback/favicon")
          )
        end

        it "uses uploaded favicon for site" do
          site = create(:site, :favicon)

          get :show

          expect(site.favicon.url).to include("/uploads/archangel/site/favicon")
        end

        it "uses default logo for site" do
          get :show

          expect(site.logo.url).to(
            include("/assets/archangel/fallback/logo")
          )
        end

        it "uses uploaded logo for site" do
          site = create(:site, :logo)

          get :show

          expect(site.logo.url).to include("/uploads/archangel/site/logo")
        end
      end

      describe "GET #edit" do
        context "with permissions" do
          let!(:profile) { create(:user, :admin, site: site) }

          it "assigns the requested site as @site" do
            get :edit

            expect(assigns(:site)).to eq(Site.current)
          end
        end

        context "without permissions" do
          let!(:profile) { create(:user, :editor, site: site) }

          it "redirects to site" do
            get :edit

            expect(response).to render_template("archangel/errors/error_401")
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe "PUT #update" do
        context "with permissions" do
          let!(:profile) { create(:user, :admin, site: site) }

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

        context "without permissions" do
          let!(:profile) { create(:user, :editor, site: site) }

          it "redirects to site" do
            put :update, params: { site: {} }

            expect(response).to render_template("archangel/errors/error_401")
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
