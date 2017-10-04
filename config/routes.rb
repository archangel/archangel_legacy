# frozen_string_literal: true

Archangel::Engine.routes.draw do
  # Pagination
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  devise_for :users,
             module: :devise,
             class_name: "Archangel::User",
             controllers: {
               registrations: "archangel/auth/registrations"
             },
             path: "",
             path_prefix: "account",
             skip: [:omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "register",
               password: "password",
               confirmation: "verification",
               unlock: "unlock"
             }
  get "account", to: redirect("account/login")

  namespace :backend, path: "backend" do
    # GET    /backend/profile/edit
    # GET    /backend/profile
    # PATCH  /backend/profile
    # PUT    /backend/profile
    # DELETE /backend/profile
    resource :profile, except: %i[create new]

    # GET   /backend/site/edit
    # GET   /backend/site
    # PATCH /backend/site
    # PUT   /backend/site
    resource :site, only: %i[edit show update]

    # GET    /backend/users
    # GET    /backend/users/page/[PAGE]
    # POST   /backend/users
    # GET    /backend/users/new
    # GET    /backend/users/[USERNAME]/edit
    # GET    /backend/users/[USERNAME]
    # PATCH  /backend/users/[USERNAME]
    # PUT    /backend/users/[USERNAME]
    # DELETE /backend/users/[USERNAME]
    resources :users, concerns: [:paginatable]

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
