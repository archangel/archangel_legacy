# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe HomepagesController, type: :controller do
      describe "GET #show" do
        it "assigns the requested page as @page" do
          page = create(:page, :homepage)

          get :show

          expect(response.content_type).to eq "text/html"
          expect(assigns(:page)).to eq(page)
        end

        it "assigns the requested page as @page for JSON request" do
          page = create(:page, :homepage)

          get :show, format: :json

          expect(response.content_type).to eq "application/json"
          expect(assigns(:page)).to eq(page)
        end

        it "returns a 404 status code when page is not found" do
          get :show

          expect(response).to render_template("archangel/errors/error_404")
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
