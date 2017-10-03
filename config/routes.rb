# frozen_string_literal: true

Archangel::Engine.routes.draw do
  namespace :backend, path: "backend" do
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
