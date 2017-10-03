# frozen_string_literal: true

Archangel::Engine.routes.draw do
  namespace :backend, path: "backend" do
    # GET   /backend/site/edit
    # GET   /backend/site
    # PATCH /backend/site
    # PUT   /backend/site
    resource :site, only: %i[edit show update]

    # GET /backend
    root to: "dashboards#show"
  end

  namespace :frontend, path: "" do
    # GET /[PATH]
    get "*path", to: "pages#show", as: :page

    # GET /
    root to: "pages#show"
  end

  # GET /
  root to: "frontend/pages#show"
end
