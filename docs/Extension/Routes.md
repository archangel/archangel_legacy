# Routes

Routes are separated by `frontend`, `backend` or `auth` namespaces. Each section should be separated for functional clarity.

## Backend Routes

For Backend routes, open `config/routes.rb` and add the following

```
Archangel::Engine.routes.draw do
  namespace :backend, path: Archangel.config.backend_path do
    # GET    /backend/foos
    # POST   /backend/foos
    # GET    /backend/foos/new
    # GET    /backend/foos/[ID]/edit
    # GET    /backend/foos/[ID]
    # PATCH  /backend/foos/[ID]
    # PUT    /backend/foos/[ID]
    # DELETE /backend/foos/[ID]
    resources :foos do
      # GET /backend/foos/custom
      get :custom
    end
  end
end
```
