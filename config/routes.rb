# frozen_string_literal: true

Archangel::Engine.routes.draw do
  # Pagination
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  # GET    /account/login
  # POST   /account/login
  # DELETE /account/logout
  # POST   /account/password
  # GET    /account/password/new
  # GET    /account/password/edit
  # PATCH  /account/password
  # PUT    /account/password
  # GET    /account/cancel
  # POST   /account
  # GET    /account/register
  # GET    /account/edit
  # PATCH  /account
  # PUT    /account
  # DELETE /account
  # POST   /account/verification
  # GET    /account/verification/new
  # GET    /account/verification
  # POST   /account/unlock
  # GET    /account/unlock/new
  # GET    /account/unlock
  # GET    /account/invitation/accept
  # GET    /account/invitation/remove
  # POST   /account/invitation
  # GET    /account/invitation/new
  # PATCH  /account/invitation
  # PUT    /account/invitation
  devise_for :users,
             module: :devise,
             class_name: "Archangel::User",
             controllers: {
               registrations: "archangel/auth/registrations"
             },
             path: "",
             path_prefix: Archangel.config.auth_path,
             skip: %i[omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "register",
               password: "password",
               confirmation: "verification",
               unlock: "unlock"
             }

  # GET /account => /account/login
  get Archangel.config.auth_path,
      to: redirect("#{Archangel.config.auth_path}/login")

  namespace :backend, path: Archangel.config.backend_path do
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

    # GET    /backend/assets
    # GET    /backend/assets/page/[PAGE]
    # POST   /backend/assets
    # GET    /backend/assets/new
    # GET    /backend/assets/[ID]/edit
    # GET    /backend/assets/[ID]
    # PATCH  /backend/assets/[ID]
    # PUT    /backend/assets/[ID]
    # DELETE /backend/assets/[ID]
    resources :assets, concerns: %i[paginatable]

    # GET    /backend/collections
    # GET    /backend/collections/page/[PAGE]
    # POST   /backend/collections
    # GET    /backend/collections/new
    # GET    /backend/collections/[SLUG]/edit
    # GET    /backend/collections/[SLUG]
    # PATCH  /backend/collections/[SLUG]
    # PUT    /backend/collections/[SLUG]
    # DELETE /backend/collections/[SLUG]
    resources :collections, concerns: %i[paginatable] do
      # GET    /backend/collections/[COLLECTION_SLUG]/entries
      # GET    /backend/collections/[COLLECTION_SLUG]/entries/page/[PAGE]
      # POST   /backend/collections/[COLLECTION_SLUG]/entries
      # GET    /backend/collections/[COLLECTION_SLUG]/entries/new
      # GET    /backend/collections/[COLLECTION_SLUG]/entries/[ID]/edit
      # GET    /backend/collections/[COLLECTION_SLUG]/entries/[ID]
      # PATCH  /backend/collections/[COLLECTION_SLUG]/entries/[ID]
      # PUT    /backend/collections/[COLLECTION_SLUG]/entries/[ID]
      # DELETE /backend/collections/[COLLECTION_SLUG]/entries/[ID]
      resources :entries, concerns: %i[paginatable]
    end

    # GET    /backend/pages
    # GET    /backend/pages/page/[PAGE]
    # POST   /backend/pages
    # GET    /backend/pages/new
    # GET    /backend/pages/[ID]/edit
    # GET    /backend/pages/[ID]
    # PATCH  /backend/pages/[ID]
    # PUT    /backend/pages/[ID]
    # DELETE /backend/pages/[ID]
    resources :pages, concerns: %i[paginatable]

    # GET    /backend/templates
    # GET    /backend/templates/page/[PAGE]
    # POST   /backend/templates
    # GET    /backend/templates/new
    # GET    /backend/templates/[ID]/edit
    # GET    /backend/templates/[ID]
    # PATCH  /backend/templates/[ID]
    # PUT    /backend/templates/[ID]
    # DELETE /backend/templates/[ID]
    resources :templates, concerns: %i[paginatable]

    # GET    /backend/users
    # GET    /backend/users/page/[PAGE]
    # POST   /backend/users
    # GET    /backend/users/new
    # GET    /backend/users/[USERNAME]/edit
    # GET    /backend/users/[USERNAME]
    # PATCH  /backend/users/[USERNAME]
    # PUT    /backend/users/[USERNAME]
    # DELETE /backend/users/[USERNAME]
    resources :users, concerns: %i[paginatable]

    # GET    /backend/widgets
    # GET    /backend/widgets/page/[PAGE]
    # POST   /backend/widgets
    # GET    /backend/widgets/new
    # GET    /backend/widgets/[SLUG]/edit
    # GET    /backend/widgets/[SLUG]
    # PATCH  /backend/widgets/[SLUG]
    # PUT    /backend/widgets/[SLUG]
    # DELETE /backend/widgets/[SLUG]
    resources :widgets, concerns: %i[paginatable]

    # GET /backend
    root to: "dashboards#show"
  end

  namespace :frontend, path: Archangel.config.frontend_path do
    # GET /[PATH]
    get ":path", to: "pages#show", as: :page,
                 constraints: {
                   path: %r{[\w\-\/]+}
                 }

    # GET /
    root to: "pages#show"
  end

  # GET /
  root to: "frontend/pages#show"
end
