# Controllers

Controllers are separated by `frontend`, `backend` or `auth` namespaces. Each section should be separated for functional clarity.

## Backend Controllers

For Backend controllers, create your controller at `app/controllers/archangel/backend/foos_controller.rb` add the following.

```
module Archangel
  module Backend
    class FoosController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @foos
      end

      def show
        respond_with @foo
      end

      def new
        respond_with @foo
      end

      def create
        @foo.save

        respond_with @foo, location: -> { location_after_create }
      end

      def edit
        respond_with @foo
      end

      def update
        @foo.update(resource_params)

        respond_with @foo, location: -> { location_after_update }
      end

      def destroy
        @foo.destroy

        respond_with @foo, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[bar bat baz slug]
      end

      def set_resources
        @foos = current_site.foos.page(page_num).per(per_page)

        authorize @foos
      end

      def set_resource
        resource_id = params.fetch(:id)

        # When `to_param` is not used in the model
        @foo = current_site.foos.find_by!(id: resource_id)

        # When `to_param` is used in the model
        # @foo = current_site.foos.find_by!(slug: resource_id)

        authorize @foo
      end

      def set_new_resource
        new_params = action_name.to_sym == :create ? resource_params : nil

        @foo = current_site.foos.new(new_params)

        authorize @foo
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        controller_name.singularize.to_sym
      end

      def location_after_create
        location_after_save
      end

      def location_after_update
        location_after_save
      end

      def location_after_destroy
        location_after_save
      end

      def location_after_save
        backend_foos_path
      end
    end
  end
end
```

Extending `BackendController` assumes your controller requires policy authorization. If your controller does not require authorization, use the following

```
module Archangel
  module Backend
    class FoosController < BackendController
      include Archangel::SkipAuthorizableConcern

      ...
    end
  end
end
```

To change the `id` for constructing a URL to this object, override `set_resource` in your controller.

```
def set_resource
  resource_id = params.fetch(:id)

  @foo = current_site.foos.find_by!(slug: resource_id)

  authorize @foo
end
```

## Testing Backend Controllers

TODO
