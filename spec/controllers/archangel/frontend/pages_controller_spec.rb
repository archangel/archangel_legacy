# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PagesController, type: :controller do
      describe "loads correct layout" do
        it "loads correct view" do
          page = create(:page)

          get :show, params: { path: page.path }

          expect(response).to render_with_layout("frontend")
        end
      end

      describe "GET #show" do
        it "assigns the requested page as @page" do
          page = create(:page)

          get :show, params: { path: page.path }

          expect(assigns(:page)).to eq(page)
        end

        it "redirects to homepage" do
          page = create(:page, :homepage)

          get :show, params: { path: page.path }

          expect(response).to redirect_to(root_path)
        end

        it "returns a 404 status code when page is not found" do
          get :show, params: { path: "not-a-real-page" }

          expect(response.response_code).to eq 404
        end
      end
    end
  end
end
