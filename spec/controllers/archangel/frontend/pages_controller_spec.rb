# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PagesController, type: :controller do
      describe "loads correct layout" do
        it "loads correct view" do
          page = create(:page)

          get :show, params: { path: page.path }

          expect(response).to render_with_layout("archangel/layouts/frontend")
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
      end
    end
  end
end
