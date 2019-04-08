# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PagesController, type: :controller do
      let(:page) { create(:page) }

      describe "loads correct layout" do
        it "loads correct view" do
          get :show, params: { permalink: page.permalink }

          expect(response).to render_with_layout("frontend")
        end
      end

      describe "GET #show" do
        it "assigns the requested page as @page" do
          get :show, params: { permalink: page.permalink }

          expect(response.content_type).to eq "text/html"
          expect(assigns(:page)).to eq(page)
        end

        it "assigns the requested page as @page for JSON request" do
          get :show, params: { permalink: page.permalink }, format: :json

          expect(response.content_type).to eq "application/json"
          expect(assigns(:page)).to eq(page)
        end

        it "redirects to homepage" do
          page = create(:page, :homepage)

          get :show, params: { permalink: page.permalink }

          expect(response).to redirect_to(root_path)
          expect(response.status).to eq(301)
        end

        it "returns a 404 status code when page is not found" do
          get :show, params: { permalink: "not-a-real-page" }

          expect(response).to render_template("archangel/errors/error_404")
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
